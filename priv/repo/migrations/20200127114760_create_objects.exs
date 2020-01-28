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

  def change do
    create table(:objects) do
      add :object_type, :string
      add :object_name, :string
      add :direction, :integer
      add :height, :float
      # add :lng, :float
      # add :lat, :float
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

    # execute("SELECT AddGeometryColumn ('objects','coordinates',4326,'POINT',2);")
    execute("SELECT AddGeometryColumn ('objects','coordinates',4326,'POINT',2);")

    create index(:objects, [:coordinates], using: :gist)

  end
end
