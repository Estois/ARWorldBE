defmodule ArworldWeb.PageController do
  use ArworldWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
