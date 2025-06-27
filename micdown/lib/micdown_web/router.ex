defmodule MicdownWeb.Router do
  use MicdownWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MicdownWeb.Plugs.FetchCurrentUser  # <--- add plug module here
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MicdownWeb do
    pipe_through :browser

    get "/", PageController, :home

    get "/confirm", MicdownWeb.ConfirmationController, :confirm_email

  end

  scope "/api", MicdownWeb do
    pipe_through :api

    post "/register", RegisterController, :create
  end



  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:micdown, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MicdownWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
      scope "/", MicdownWeb do
      pipe_through [:browser] # use whatever auth plug you made
      get "/messages/:user_id", MessageController, :index
      post "/messages", MessageController, :create
    end
  end
end
