defmodule CometWeb.StreamBlobUpload do
  @moduledoc """
  Manages a streaming blob upload to a PDS via `com.atproto.repo.uploadBlob`.

  Spawns a task that holds an open HTTP request with a stream body. Chunks are
  fed in via `write_chunk/2`; `finish/1` signals the end and returns the blob.

  Intended to back `Phoenix.LiveView.UploadWriter` implementations that need
  to forward chunks to the PDS, optionally with pre-processing (e.g. transcoding).

  ## Usage

      {:ok, upload} = CometWeb.StreamBlobUpload.init(client, "audio/opus", byte_size)
      CometWeb.StreamBlobUpload.write_chunk(chunk, upload)
      {:ok, blob} = CometWeb.StreamBlobUpload.finish(upload)

      # On cancellation or error:
      CometWeb.StreamBlobUpload.cancel(upload)
  """

  defstruct [:task, :task_pid]

  @type t :: %__MODULE__{task: Task.t(), task_pid: pid()}

  @doc """
  Starts a streaming upload to `com.atproto.repo.uploadBlob`.

  Spawns a task that opens the HTTP request with a chunked stream body and
  waits for chunks to be fed in. Returns `{:ok, upload}` once ready.
  """
  @spec init(Atex.XRPC.Client.client(), String.t(), non_neg_integer()) ::
          {:ok, t()} | {:error, :task_start_timeout}
  def init(xrpc_client, content_type, content_length) do
    caller = self()

    task =
      Task.Supervisor.async_nolink(Comet.TaskSupervisor, fn ->
        send(caller, {:ready, self()})

        stream =
          Stream.resource(
            fn -> :ok end,
            fn acc ->
              receive do
                {:chunk, data} -> {[data], acc}
                :done -> {:halt, acc}
              end
            end,
            fn _acc -> :ok end
          )

        # TODO: pass struct when next atex update is released
        Atex.XRPC.post(xrpc_client, "com.atproto.repo.uploadBlob",
          body: stream,
          headers: [
            {"content-type", content_type},
            {"content-length", to_string(content_length)}
          ]
        )
      end)

    receive do
      {:ready, task_pid} ->
        {:ok, %__MODULE__{task: task, task_pid: task_pid}}
    after
      5_000 -> {:error, :task_start_timeout}
    end
  end

  @doc """
  Sends a chunk to the upload stream.
  """
  @spec write_chunk(binary(), t()) :: :ok
  def write_chunk(data, %__MODULE__{task_pid: task_pid}) do
    send(task_pid, {:chunk, data})
    :ok
  end

  @doc """
  Signals the end of the upload and waits for the PDS response.

  Returns `{:ok, blob}` where `blob` is the raw blob map from the PDS, or
  `{:error, reason}` on failure.
  """
  @spec finish(t()) :: {:ok, map()} | {:error, term()}
  def finish(%__MODULE__{task: task, task_pid: task_pid}) do
    send(task_pid, :done)

    result =
      try do
        Task.await(task, :infinity)
      rescue
        e -> {:error, Exception.message(e), nil}
      catch
        :exit, reason -> {:error, reason, nil}
      end

    case result do
      {:ok, %{body: %{"blob" => blob}}, _client} -> {:ok, blob}
      {:ok, response, _client} -> {:error, {:unexpected_response, response}}
      {:error, reason, _client} -> {:error, reason}
    end
  end

  @doc """
  Cancels the upload and kills the upload task immediately.
  """
  @spec cancel(t()) :: :ok
  def cancel(%__MODULE__{task: task}) do
    Task.shutdown(task, :brutal_kill)
    :ok
  end
end
