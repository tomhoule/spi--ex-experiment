defmodule SpinozaEx.Router do
  use SpinozaEx.Web, :router

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

  scope "/", SpinozaEx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/editions", EditionController do
      get "/fragments", FragmentController, :index
      get "/fragments/new", FragmentController, :new
      post "/fragments/create", FragmentController, :create
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpinozaEx do
  #   pipe_through :api
  # end
end
