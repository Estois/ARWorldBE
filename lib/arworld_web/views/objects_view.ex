defmodule ArworldWeb.ObjectsView do
  use ArworldWeb, :view
  alias ArworldWeb.ObjectsView

  def render("index.json", %{objects: objects}) do
    %{data: render_many(objects, ObjectsView, "objects.json")}
  end

  def render("show.json", %{objects: objects}) do
    %{data: render_one(objects, ObjectsView, "objects.json")}
  end

  def render("objects.json", %{objects: objects}) do
    %{id: objects.id,
      object_type: objects.object_type,
      object_name: objects.object_name,
      direction: objects.direction,
      height: objects.height,
      lng: objects.lng,
      lat: objects.lat,
      is_active: objects.is_active}
  end
end
