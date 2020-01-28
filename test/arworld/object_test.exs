defmodule Arworld.ObjectTest do
  use Arworld.DataCase

  alias Arworld.Object

  describe "objects" do
    alias Arworld.Object.Objects

    @valid_attrs %{direction: 42, height: 120.5, is_active: true, lat: 120.5, lng: 120.5, object_name: "some object_name", object_type: "some object_type"}
    @update_attrs %{direction: 43, height: 456.7, is_active: false, lat: 456.7, lng: 456.7, object_name: "some updated object_name", object_type: "some updated object_type"}
    @invalid_attrs %{direction: nil, height: nil, is_active: nil, lat: 999, lng: 999, object_name: nil, object_type: nil}

    def objects_fixture(attrs \\ %{}) do
      {:ok, objects} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Object.create_objects()

      objects
    end

    test "list_objects/0 returns all objects" do
      objects = %{objects_fixture()| lat: nil, lng: nil}
      assert Object.list_objects() == [objects]
    end

    test "get_objects!/1 returns the objects with given id" do
      objects = %{objects_fixture()| lat: nil, lng: nil}
      assert Object.get_objects!(objects.id) == objects
    end

    test "create_objects/1 with valid data creates a objects" do
      assert {:ok, %Objects{} = objects} = Object.create_objects(@valid_attrs)
      assert objects.direction == 42
      assert objects.height == 120.5
      assert objects.is_active == true
      # assert objects.lat == 120.5
      # assert objects.lng == 120.5
      assert objects.coordinates == %Geo.Point{coordinates: {120.5, 120.5}, srid: 4326}
      assert objects.object_name == "some object_name"
      assert objects.object_type == "some object_type"
    end

    test "create_objects/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Object.create_objects(@invalid_attrs)
    end

    test "update_objects/2 with valid data updates the objects" do
      objects = objects_fixture()
      assert {:ok, %Objects{} = objects} = Object.update_objects(objects, @update_attrs)
      assert objects.direction == 43
      assert objects.height == 456.7
      assert objects.is_active == false
      # assert objects.lat == 456.7
      # assert objects.lng == 456.7
      assert objects.coordinates == %Geo.Point{coordinates: {456.7, 456.7}, srid: 4326}
      assert objects.object_name == "some updated object_name"
      assert objects.object_type == "some updated object_type"
    end

    test "update_objects/2 with invalid data returns error changeset" do
      objects = objects_fixture()
      assert {:error, %Ecto.Changeset{}} = Object.update_objects(objects, @invalid_attrs)
      assert objects == Object.get_objects!(objects.id)
    end

    test "delete_objects/1 deletes the objects" do
      objects = objects_fixture()
      assert {:ok, %Objects{}} = Object.delete_objects(objects)
      assert_raise Ecto.NoResultsError, fn -> Object.get_objects!(objects.id) end
    end

    test "change_objects/1 returns a objects changeset" do
      objects = objects_fixture()
      assert %Ecto.Changeset{} = Object.change_objects(objects)
    end
  end
end
