defmodule CometWeb.PageController do
  use CometWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
