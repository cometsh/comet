defmodule CometWeb.PageController do
  use CometWeb, :controller

  def home(conn, _params) do
    # TODO: automaticaly put client as an assign on conn if valid
    case Atex.XRPC.OAuthClient.from_conn(conn) do
      {:ok, %{did: did}} ->
        render(conn, :home, did: did)

      _ ->
        render(conn, :home, did: nil)
    end
  end
end
