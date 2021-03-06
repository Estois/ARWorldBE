defmodule ArworldWeb.Router do
  use ArworldWeb, :router

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

  scope "/", ArworldWeb do
    pipe_through :browser

    get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
  scope "/api", ArworldWeb do
    pipe_through :api

    get "/synchronise", SyncController, :synchronise

    post "/create", SyncController, :create

    put "/update", SyncController, :update

    put "/delete", SyncController, :delete

  end
end
