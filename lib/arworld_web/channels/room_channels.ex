defmodule ArworldWeb.RoomChannel do
  use ArworldWeb, :channel

  def join(channel_name, _params, socket) do
    {:ok, %{channel: channel_name}, socket}
  end
end
