defmodule CometWeb.PageController do
  use CometWeb, :controller

  def home(conn, _params) do
    conn
    |> put_flash(:error, "What's up gang?")
    |> render(:home)
  end
end
