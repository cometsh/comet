defmodule CometWeb.Uploads.BlobWriterTest do
  use ExUnit.Case, async: true

  alias CometWeb.Uploads.BlobWriter

  # Minimal XRPC client test double. Drains the body stream and returns a
  # canned response, so no real HTTP happens.
  defmodule TestClient do
    @behaviour Atex.XRPC.Client
    defstruct [:response]

    @impl true
    def get(_client, _resource, _opts), do: {:error, :not_implemented, %__MODULE__{}}

    @impl true
    def post(%__MODULE__{response: response} = client, _resource, opts) do
      # Consume the stream — this unblocks receive loops in StreamBlobUpload's task.
      opts |> Keyword.fetch!(:body) |> Enum.to_list()
      {tag, _, _} = response
      {tag, elem(response, 1), client}
    end
  end

  defp blob_response do
    body = %{
      "blob" => %{
        "$type" => "blob",
        "ref" => %{"$link" => "bafkreitest"},
        "mimeType" => "image/jpeg",
        "size" => 3
      }
    }

    {:ok, %{status: 200, body: body, headers: %{}}, nil}
  end

  defp error_response do
    {:error, %{status: 400, body: %{"error" => "InvalidBlob"}, headers: %{}}, nil}
  end

  defp make_opts(overrides \\ []) do
    Keyword.merge(
      [
        xrpc_client: %TestClient{response: blob_response()},
        content_type: "image/jpeg",
        content_length: 3
      ],
      overrides
    )
  end

  # --- init ---

  test "init/1 returns ok state with upload set and blob nil" do
    assert {:ok, state} = BlobWriter.init(make_opts())
    assert is_pid(state.upload.task_pid)
    assert is_nil(state.blob)
    Task.shutdown(state.upload.task, :brutal_kill)
  end

  # --- meta ---

  test "meta/1 returns nil blob before close" do
    {:ok, state} = BlobWriter.init(make_opts())
    assert %{blob: nil} = BlobWriter.meta(state)
    Task.shutdown(state.upload.task, :brutal_kill)
  end

  # --- write_chunk ---

  test "write_chunk/2 returns ok without changing upload" do
    {:ok, state} = BlobWriter.init(make_opts())
    assert {:ok, new_state} = BlobWriter.write_chunk("abc", state)
    assert new_state.upload.task_pid == state.upload.task_pid
    Task.shutdown(state.upload.task, :brutal_kill)
  end

  # --- close :done ---

  test "close/2 :done awaits upload and stores blob in state" do
    {:ok, state} = BlobWriter.init(make_opts())
    BlobWriter.write_chunk("abc", state)
    assert {:ok, final} = BlobWriter.close(state, :done)
    assert %{"$type" => "blob"} = final.blob
  end

  test "meta/1 returns blob after successful close :done" do
    {:ok, state} = BlobWriter.init(make_opts())
    BlobWriter.write_chunk("abc", state)
    {:ok, final} = BlobWriter.close(state, :done)
    assert %{blob: %{"$type" => "blob"}} = BlobWriter.meta(final)
  end

  test "close/2 :done returns error when upload fails" do
    opts = make_opts(xrpc_client: %TestClient{response: error_response()})
    {:ok, state} = BlobWriter.init(opts)
    BlobWriter.write_chunk("abc", state)
    assert {:error, _reason} = BlobWriter.close(state, :done)
  end

  # --- close cancel/error ---

  test "close/2 :cancel shuts down task immediately" do
    {:ok, state} = BlobWriter.init(make_opts())
    assert {:ok, _} = BlobWriter.close(state, :cancel)
    refute Process.alive?(state.upload.task_pid)
  end

  test "close/2 {:error, reason} shuts down task immediately" do
    {:ok, state} = BlobWriter.init(make_opts())
    assert {:ok, _} = BlobWriter.close(state, {:error, :some_reason})
    refute Process.alive?(state.upload.task_pid)
  end
end
