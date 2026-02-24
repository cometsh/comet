defmodule CometWeb.LoginLive do
  use CometWeb, :live_view

  def render(assigns) do
    ~H"""
    <.link href={~p"/"}>Go home</.link>

    <.form for={@form} id="login-form" phx-change="validate" phx-submit="submit">
      <.input type="text" field={@form[:handle]} placeholder="alice.bsky.social" autofocus />
      <button type="submit">Submit</button>
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{"handle" => ""}))}
  end

  def handle_event("validate", %{"handle" => handle}, socket) do
    errors =
      handle
      |> validate()
      |> case do
        nil -> []
        msg -> [errors: [handle: {msg, []}]]
      end

    socket
    |> assign(form: to_form(%{"handle" => handle}, errors))
    |> noreply()
  end

  def handle_event("submit", %{"handle" => handle}, socket) do
    # TODO: resolve identity first and error early here
    errors =
      handle
      |> validate(true)
      |> case do
        nil -> []
        msg -> [errors: [handle: {msg, []}]]
      end

    if errors == [] do
      socket
      |> redirect(to: ~p"/oauth/login?handle=#{handle}")
      |> noreply()
    else
      socket
      |> assign(form: to_form(%{"handle" => handle}, errors))
      |> noreply()
    end
  end

  @spec validate(String.t(), boolean()) :: String.t() | nil
  defp validate(handle, resolve \\ false)

  defp validate(handle, true) do
    handle
    |> validate()
    |> case do
      nil ->
        case Atex.IdentityResolver.resolve(handle) do
          {:ok, _} ->
            nil

          {:error, err} ->
            IO.inspect(err, label: "Failed to resolve")
            "Failed to resolve identity"

          # TODO: correct typespec in Atex
          :error ->
            "Failed to resolve identity"
        end

      msg ->
        msg
    end
  end

  defp validate(handle, false) do
    cond do
      handle == "" -> "Can't be blank"
      # TODO: better copy
      !Atex.Handle.match?(handle) -> "Must be a valid AT Proto handle"
      true -> nil
    end
  end
end
