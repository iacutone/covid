defmodule CovidWeb.Router do
  use CovidWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CovidWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
  end

  scope "/", CovidWeb do
    pipe_through :browser

    resources "/register", UserController, only: [:create, :new]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/", CovidWeb do
    pipe_through [:browser, Covid.Plugs.AuthenticateUser]

    live "/", QuestionnaireLive
    live "/company", CompanyLive
    live "/questionnaire", QuestionnaireLive
    live "/reports", ReportsLive
    live "/workers", WorkerLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", CovidWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CovidWeb.Telemetry
    end
  end
end
