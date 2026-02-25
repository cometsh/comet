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

      <%= if @audio_cid do %>
        <p>Uploaded audio file as blob! cid: <code>{@audio_cid}</code></p>
      <% end %>

      <%= if @record_uri do %>
        <p>
          Created PDS record! explore in pdsls:
          <a target="_blank" href={"https://pdsls.dev/#{@record_uri}"}><code>{@record_uri}</code></a>
        </p>
      <% end %>
    </.form>
    """
  end

  def mount(_params, session, socket) do
    # TODO: add function in Atex to do this to hide the use of a special key
    did = session["atex_session"]

    {
      :ok,
      socket
      |> assign(
        audio_cid: nil,
        record_uri: nil,
        form: to_form(%{"title" => "", "description" => "", "explicit" => false}),
        did: did
      )
      # TODO: preprocessing on the client to allow larger files, to be able to properly hit the 100mb limit in the lexicon
      # likely through a custom upload provider?
      |> allow_upload(:audio, accept: ["audio/*"], max_file_size: @audio_size_limit)
      |> allow_upload(:image, accept: ["image/*"], max_file_size: @image_size_limit)
    }
  end

  def handle_event("validate", %{"title" => title} = params, socket) do
    IO.inspect(params, label: "validate")

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
    IO.inspect(params, label: "submit")
    did = socket.assigns.did

    # TODO: process description facets

    case title do
      "" ->
        socket
        |> assign(form: to_form(params, errors: [title: {"Can't be blank", []}]))
        |> noreply()

      _ ->
        # TODO: process files in a separate step to give feedback to the UI? will need to do a search to see the best way for this.

        # TODO: `consume_uploaded_entries` only allows `:ok` or `:postpone` tuples as return.
        # Is there a proper/widely-done convention for upload processing stuff in Phoenix?
        [{audio_cid, record_uri}] =
          consume_uploaded_entries(socket, :audio, fn %{path: in_path}, entry ->
            tmp_dir = System.tmp_dir!()
            out_path = Path.join(tmp_dir, entry.uuid)

            # TODO: copy ports stuff from Nostrum voice; is it possible to pipe a stream into a Req body??
            # double TODO: Need to add streaming support to atex xrpc if so
            # triple TODO: probably need to cache uploaded files and their transcodes to prevent re-encoding of duplicate files
            {_out, exit_code} =
              System.cmd(
                ffmpeg_executable(),
                [
                  "-i",
                  in_path,
                  "-map",
                  "0:a",
                  "-c:a",
                  "libopus",
                  "-b:a",
                  "96k",
                  "-f",
                  "opus",
                  "-map_metadata",
                  "1",
                  out_path
                ],
                stderr_to_stdout: true
              )

            case exit_code do
              0 ->
                with {:ok, client} <- Atex.XRPC.OAuthClient.new(did),
                     {:ok, %{body: %{blob: audio_blob}}, client} <-
                       Atex.XRPC.post(
                         client,
                         %Com.Atproto.Repo.UploadBlob{
                           raw_input: File.read!(out_path)
                         },
                         headers: ["Content-Type": "audio/opus"]
                       ),
                     {:ok, %{body: record}, _} <-
                       Atex.XRPC.post(client, %Com.Atproto.Repo.CreateRecord{
                         input: %Com.Atproto.Repo.CreateRecord.Input{
                           collection: "sh.comet.v0.feed.track",
                           repo: client.did,
                           rkey: to_string(Atex.TID.now()),
                           record: %Sh.Comet.V0.Feed.Track{
                             audio: audio_blob,
                             title: params["title"],
                             description: params["description"],
                             explicit: params["explicit"],
                             createdAt: DateTime.utc_now() |> DateTime.to_iso8601()
                           }
                         }
                       }) do
                  {:ok, {audio_blob.ref."$link", record.uri}}
                end

              e ->
                # TODO: send ffmpeg output somewhere for observability
                Logger.error("ffmpeg on upload errored with exit code: #{e}")
                {:error, :ffmpeg}
            end
          end)

        socket
        |> assign(audio_cid: audio_cid, record_uri: record_uri)
        |> noreply()
    end
  end

  defp ffmpeg_executable, do: Application.get_env(:comet, :ffmpeg_bin, "ffmpeg")
end
