defmodule CometWeb.UploadLive do
  use CometWeb, :live_view
  require Logger

  # 50mb
  @audio_size_limit 50_000_000
  # 1mb
  @image_size_limit 1_000_000

  # TODO: drag and drops
  def render(assigns) do
    ~H"""
    <.link href={~p"/"}>Go home</.link>

    <.form for={@form} id="upload-form" phx-change="validate" phx-submit="submit">
      <section>
        <.live_file_input upload={@uploads.audio} required />
        <div :for={entry <- @uploads.audio.entries}>
          <progress value={entry.progress} max="100">{entry.progress}% </progress>
        </div>
      </section>

      <section>
        <.live_file_input upload={@uploads.image} />
        <div :for={entry <- @uploads.image.entries}>
          <figure>
            <.live_img_preview
              entry={entry}
              style="aspect-ratio: 1; max-width: 200px; max-height: 200px; object-size: contain; object-position: center;"
            />
            <figcaption>{entry.client_name}</figcaption>
          </figure>
          <progress value={entry.progress} max="100">{entry.progress}% </progress>
        </div>
      </section>

      <.input type="text" field={@form[:title]} placeholder="Dope beat" maxlength="256" required />
      <.input
        type="textarea"
        field={@form[:description]}
        placeholder="Some cool description"
        maxlength="2000"
      />
      <.input type="checkbox" field={@form[:explicit]} label="Explicit content?" />

      <button type="submit">Upload</button>

      <%= if @record do %>
        <p>
          Created PDS record! explore in pdsls:
          <a target="_blank" href={"https://pdsls.dev/#{@record.uri}"}><code>{@record.uri}</code></a>
        </p>
      <% end %>
    </.form>
    """
  end

  def mount(_params, session, socket) do
    # TODO: add function in Atex to do this to hide the use of a special key
    {:ok, client} = Atex.XRPC.OAuthClient.new(session["atex_active_session"])

    {
      :ok,
      socket
      |> assign(
        record: nil,
        form: to_form(%{"title" => "", "description" => "", "explicit" => false}),
        _atex_session: session["atex_active_session"]
      )
      |> allow_upload(:audio,
        accept: ["audio/*"],
        max_file_size: @audio_size_limit,
        writer: fn _name, entry, _socket ->
          {CometWeb.Uploads.BlobWriter,
           xrpc_client: client, content_type: entry.client_type, content_length: entry.client_size}
        end
      )
      |> allow_upload(:image,
        accept: ["image/*"],
        max_file_size: @image_size_limit,
        writer: fn _name, entry, _socket ->
          {CometWeb.Uploads.BlobWriter,
           xrpc_client: client, content_type: entry.client_type, content_length: entry.client_size}
        end
      )
    }
  end

  def handle_event("validate", %{"title" => title} = params, socket) do
    errors =
      case title do
        "" -> [errors: [title: {"Can't be blank", []}]]
        _ -> []
      end

    socket
    |> assign(form: to_form(params, errors))
    |> noreply()
  end

  def handle_event("submit", %{"title" => title} = params, socket) do
    # did = socket.assigns.did
    session = socket.assigns._atex_session

    # TODO: process description facets

    case title do
      "" ->
        socket
        |> assign(form: to_form(params, errors: [title: {"Can't be blank", []}]))
        |> noreply()

      _ ->
        [audio_blob] =
          consume_uploaded_entries(socket, :audio, fn %{blob: blob}, _entry ->
            {:ok, blob}
          end)

        [image_blob] =
          consume_uploaded_entries(socket, :image, fn %{blob: blob}, _entry ->
            {:ok, blob}
          end)

        {:ok, record} =
          with {:ok, client} <- Atex.XRPC.OAuthClient.new(session),
               {:ok, %{body: record}, _} <-
                 Atex.XRPC.post(client, %Com.Atproto.Repo.CreateRecord{
                   input: %Com.Atproto.Repo.CreateRecord.Input{
                     collection: "sh.comet.v0.feed.track",
                     repo: Atex.XRPC.OAuthClient.did(client),
                     rkey: to_string(Atex.TID.now()),
                     record: %Sh.Comet.V0.Feed.Track{
                       audio: audio_blob,
                       image: image_blob,
                       title: params["title"],
                       description: params["description"],
                       explicit: params["explicit"],
                       createdAt: DateTime.utc_now() |> DateTime.to_iso8601()
                     }
                   }
                 }) do
            {:ok, record}
          end

        socket
        |> assign(record: record)
        |> noreply()
    end
  end
end
