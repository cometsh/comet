defmodule CometWeb.Router do
  use CometWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CometWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    forward "/oauth", Atex.OAuth.Plug, [callback: {__MODULE__, :oauth_callback, []}]

    get "/", CometWeb.PageController, :home
  end

  def oauth_callback(conn) do
    # Handle successful OAuth authentication
    conn
    |> put_resp_header("Location", "/")
    |> resp(307, "")
    |> send_resp()
  end

  # Other scopes may use custom stacks.
  # scope "/api", CometWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:comet, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CometWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

defimpl Plug.Exception, for: Atex.OAuth.Error do
  def status(%{reason: reason}) when reason in [:missing_handle, :invalid_handle, :invalid_callback_request, :issuer_mismatch], do: 400
  def status(_exception), do: 500
  def actions(_exception), do: []
end
