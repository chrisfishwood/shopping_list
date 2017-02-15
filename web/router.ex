defmodule AuthExample.Router do
  use AuthExample.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: AuthExample.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthExample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    #resources "/users", UserController
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", AuthExample do
    pipe_through [:browser, :browser_auth]
    resources "/users", UserController, only: [:show, :index, :update, :edit, :delete]
  end
#
  # Other scopes may use custom stacks.
  # scope "/api", AuthExample do
  #   pipe_through :api
  # end
end
