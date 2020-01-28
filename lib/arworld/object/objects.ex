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

  def get_objects_in_radius() do
    query = ["SELECT * FROM objects;"]
    #|> Enum.join(" ") will need this for multiple line querying later

    case Repo.query(query)do
      {:ok, %Postgrex.Result{columns: cols, rows: rows}} ->
        results =
          Enum.map(rows, fn row ->
            Repo.load(Objects, {cols, row})
          end)

        {:ok, results} ->
    end
    # Repo.query(query)
  end

end
