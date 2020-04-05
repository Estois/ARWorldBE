defmodule Arworld.Object.Objects do
  use Ecto.Schema
  import Ecto.Changeset

  alias Arworld.{Repo, Object.Objects}

  schema "objects" do
    field :direction, :integer
    field :height, :float
    field :is_active, :boolean, default: false
    field :coordinates, Geo.PostGIS.Geometry
    field :lat, :float, virtual: true
    field :lng, :float, virtual: true
    field :object_name, :string
    field :object_type, :string

    timestamps()
  end

  @doc false
  # def changeset(objects, attrs) do
  #   objects
  #   |> cast(attrs, [:object_type, :object_name, :direction, :height, :lng, :lat, :is_active])
  #   |> validate_required([:object_type, :object_name, :direction, :height, :lng, :lat, :is_active])
  # end

  def changeset(%Objects{} = objects, attrs) do
    objects
    |> cast(attrs, [:object_type, :object_name, :direction, :height, :lng, :lat, :is_active])
    |> validate_required([:object_type, :object_name, :direction, :height, :lng, :lat, :is_active])
    |> cast_coordinates()        # remember to cast the coordinates!
  end


  def cast_coordinates(changeset) do
    lat = get_change(changeset, :lat)
    lng = get_change(changeset, :lng)
    geo = %Geo.Point{coordinates: {lng, lat}, srid: 4326}
    changeset |> put_change(:coordinates, geo)
  end

  def get_all_objects() do
    query = ["SELECT * FROM objects;"]

    case Repo.query(query)do
      {:ok, %Postgrex.Result{columns: cols, rows: rows}} ->
        results =
          Enum.map(rows, fn row ->
            Repo.load(Objects, {cols, row})
          end)

        {:ok, results} ->
    end
  end

  def get_objects_in_radius(coord) do
    lat = Map.get(coord, "lat")
    lng = Map.get(coord, "lng")
    query = ["SELECT *
              FROM objects
              WHERE ST_DWithin(objects, ST_MakePoint("<>lng<>","<>lat<>")) <= radius_mi * 16.0934"]

    case Repo.query(query)do
      {:ok, %Postgrex.Result{columns: cols, rows: rows}} ->
        results =
          Enum.map(rows, fn row ->
            Repo.load(Objects, {cols, row})
          end)

        {:ok, results} ->
    end
  end

  def get_objects!(id), do: Repo.get!(Objects, id)

  def update_objects(%Objects{} = object, object_params) do
    object
    |> changeset(object_params)
    |> Repo.update()
  end

  def delete_objects(%Objects{} = object, object_params) do
    object
    |> changeset(object_params)
    |> Repo.delete()
  end

  def create_objects(changeset_input) do
    Repo.insert (changeset_input)
  end

end
