defmodule CometWeb.Plugs.RequireAtexSession do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    case Atex.XRPC.OAuthClient.from_conn(conn) do
      {:ok, _client} ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You must be signed in to access that page.")
        |> redirect(to: "/login")
        |> halt()
    end
  end
end
