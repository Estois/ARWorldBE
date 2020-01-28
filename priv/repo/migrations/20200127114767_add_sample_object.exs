# defmodule Arworld.Repo.Migrations.EnablePostgis do
#   use Ecto.Migration
#
#   def up do
#     execute "CREATE EXTENSION IF NOT EXISTS postgis"
#   end
#
#   def down do
#     execute "DROP EXTENSION IF EXISTS postgis"
#   end
# end

defmodule Arworld.Repo.Migrations.CreateObjects do
  use Ecto.Migration

  alias Arworld.Object.Objects
  alias Arworld.Repo

  def change do
    attrs = %{
      direction: 0,
      height: 3,
      is_active: true,
      lat: 200,
      lng: 200,
      object_name: "squareboi2",
      object_type: "square1"
    }

    changeset = Objects.changeset(%Objects{}, attrs)
    Repo.insert(changeset)
  end
end
