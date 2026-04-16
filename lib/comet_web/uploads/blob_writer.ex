defmodule CometWeb.Uploads.BlobWriter do
  @moduledoc """
  A Phoenix LiveView upload writer that streams uploaded chunks directly to a
  user's PDS as a blob via `com.atproto.repo.uploadBlob`.

  Pass to `allow_upload/3` via the `:writer` option:

      allow_upload(:image,
        accept: ["image/*"],
        max_file_size: 1_000_000,
        writer: fn _name, entry, socket ->
          {:ok, client} = Atex.XRPC.YourClient.new(...)
          {CometWeb.Uploads.BlobWriter,
           xrpc_client: client,
           content_type: entry.client_type,
           content_length: entry.client_size}
        end
      )

  After consuming the entry, `meta/1` returns `%{blob: blob}` where `blob` is
  the raw blob map returned by the PDS.
  """

  @behaviour Phoenix.LiveView.UploadWriter

  alias CometWeb.StreamBlobUpload

  @impl true
  def init(opts) do
    client = Keyword.fetch!(opts, :xrpc_client)
    content_type = Keyword.fetch!(opts, :content_type)
    content_length = Keyword.fetch!(opts, :content_length)

    case StreamBlobUpload.init(client, content_type, content_length) do
      {:ok, upload} -> {:ok, %{upload: upload, blob: nil}}
      {:error, reason} -> {:error, reason}
    end
  end

  @impl true
  def meta(state), do: %{blob: state.blob}

  @impl true
  def write_chunk(data, state) do
    StreamBlobUpload.write_chunk(data, state.upload)
    {:ok, state}
  end

  @impl true
  def close(state, :done) do
    case StreamBlobUpload.finish(state.upload) do
      {:ok, blob} -> {:ok, %{state | blob: blob}}
      {:error, reason} -> {:error, reason}
    end
  end

  def close(state, _reason) do
    StreamBlobUpload.cancel(state.upload)
    {:ok, state}
  end
end
