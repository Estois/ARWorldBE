defmodule ArworldWeb.SyncController do
  use ArworldWeb, :controller

  alias Arworld.Object.Objects
  alias Arworld.Repo

  def synchronise(conn, %{"coord" => coord} = params) do
    objects = Objects.get_objects_in_radius()
    render(conn, "index.json", objects: objects)
  end

  def create(conn, %{"object" => object_params}) do
    # convert params to object here
    # instruction = Jason.decode!(params.body)
    # IO.inspect(instruction)
    # attrs = %{
    #   direction: instruction.direction,
    #   height: instruction.height,
    #   is_active: instruction.is_active,
    #   lat: instruction.lat,
    #   lng: instruction.lng,
    #   object_name: instruction.object_name,
    #   object_type: instruction.object_type
    # }
    # to be put into objects file
    changeset = Objects.changeset(%Objects{}, object_params)
    IO.inspect(changeset)
    case Repo.insert (changeset) do
      {:ok, object} ->
        json conn |> put_status(:created), %{success: ["object created"]}
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to create object"] }
    end

  end

  def update(conn, %{"id" => id, "object" => object_params}) do
    # id = params.id
    object = Objects.get_object!(id)

    case Objects.update_object(object, object_params) do
      {:ok, object} ->
        json conn |> put_status(:created), %{success: ["object updated"]}
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to update object"] }
    end

  end

  # def synchronise(conn, _params) do
  #   render(conn, "index.html")
  # end
end
