defmodule InfleetMarsElixirWeb.Router do
  use InfleetMarsElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InfleetMarsElixirWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/app", PageController, :page
    get "/app/:resource", PageController, :page
    get "/app/:resource/:id", PageController, :page
  end

  scope "/api", InfleetMarsElixirWeb do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/movables", MovablesController, except: [:new, :edit]
      resources "/movements", MovementsController, except: [:new, :edit]

      resources "/world", WorldController, only: [:index, :update]
    end
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: InfleetMarsElixirWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
