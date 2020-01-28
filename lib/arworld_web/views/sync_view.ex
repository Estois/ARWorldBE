defmodule ArworldWeb.SyncView do
  use ArworldWeb, :view
  alias ArworldWeb.SyncView

  def render("index.json", %{objects: objects}) do
    %{data: render_many(objects, SyncView, "object.json", as: :object)}
  end

  def render("object.json", %{object: object}) do
    geom = object.coordinates
    coord = Geo.JSON.encode!(geom) |> Jason.encode!
    {status, list} = Jason.decode(coord)
    coord1 = list["coordinates"]
    lng = List.first(coord1)
    lat = List.last(coord1)
    %{id: object.id,
      object_type: object.object_type,
      object_name: object.object_name,
      direction: object.direction,
      height: object.height,
      is_active: object.is_active,
      # coordinates: coord1,
      lng: lng,
      lat: lat
    }
  end

end
