defmodule ArworldWeb.ObjectsController do
  use ArworldWeb, :controller

  alias Arworld.Object
  alias Arworld.Object.Objects

  action_fallback ArworldWeb.FallbackController

  def index(conn, _params) do
    objects = Object.list_objects()
    render(conn, "index.json", objects: objects)
  end

  def create(conn, %{"objects" => objects_params}) do
    with {:ok, %Objects{} = objects} <- Object.create_objects(objects_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.objects_path(conn, :show, objects))
      |> render("show.json", objects: objects)
    end
  end

  def show(conn, %{"id" => id}) do
    objects = Object.get_objects!(id)
    render(conn, "show.json", objects: objects)
  end

  def update(conn, %{"id" => id, "objects" => objects_params}) do
    objects = Object.get_objects!(id)

    with {:ok, %Objects{} = objects} <- Object.update_objects(objects, objects_params) do
      render(conn, "show.json", objects: objects)
    end
  end

  def delete(conn, %{"id" => id}) do
    objects = Object.get_objects!(id)

    with {:ok, %Objects{}} <- Object.delete_objects(objects) do
      render(conn, "show.json", objects: objects)
    end
  end
end
