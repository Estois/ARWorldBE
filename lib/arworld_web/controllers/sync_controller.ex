defmodule ArworldWeb.SyncController do
  use ArworldWeb, :controller

  alias Arworld.Object.Objects

  def synchronise(conn, %{"coord" => coord} = params) do
    objects = Objects.get_objects_in_radius()
    render(conn, "index.json", objects: objects)
  end

  # def synchronise(conn, _params) do
  #   render(conn, "index.html")
  # end
end
