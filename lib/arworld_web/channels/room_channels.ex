defmodule ArworldWeb.RoomChannel do
  use ArworldWeb, :channel

  alias Arworld.Object.Objects
  alias ArworldWeb.SyncController

  def join("room: lobby", _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
    instruction = Map.get(body, "instruction")
    object_params = Map.get(body, "object_params")

    case instruction do
      # create object
      0 ->
        Objects.create_object(Objects.changeset(%Objects{}, object_params))
      # update object
      1 ->
        Objects.update_object(Objects.get_object!(body.id), object_params)
      # delete object
      2 ->
        Objects.delete_object(Objects.get_object!(body.id), object_params)
    end

  end

end
