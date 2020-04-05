defmodule ArworldWeb.SyncController do
  use ArworldWeb, :controller

  alias Arworld.Object.Objects
  alias Arworld.Repo

  def index(conn, _params) do
    objects = Objects.get_all_objects()
    render(conn, "index.json", objects: objects)
  end

  def synchronise(conn, params) do
    case Map.has_key?(params, "coord") do
      true ->
        objects = Objects.get_objects_in_radius(Map.keys(params, "coord"))
        render(conn, "index.json", objects: objects)
      false ->
        render(conn, "error.json")
    end
  end

  def create(conn, %{"object" => object_params}) do
    changeset = Objects.changeset(%Objects{}, object_params)

    case Objects.create_objects(changeset) do
        {:ok, object} ->
          json conn |> put_status(:created), %{success: ["object created"]}
        {:error, _changeset} ->
          json conn |> put_status(:bad_request), %{errors: ["unable to create object"] }
    end

  end

  def update(conn, %{"id" => id, "object" => object_params}) do
    object = Objects.get_object!(id)

    case Objects.update_objects(object, object_params) do
      {:ok, object} ->
        json conn |> put_status(:created), %{success: ["object updated"]}
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to update object"] }
    end
  end

  def delete(conn, %{"id" => id, "object" => object_params}) do
    object = Objects.get_object!(id)
    case Objects.delete_objects(object, object_params) do
      {:ok, object} ->
        json conn |> put_status(:created), %{success: ["object deleted"]}
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to delete object"] }
    end
  end

end
