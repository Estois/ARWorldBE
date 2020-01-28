defmodule ArworldWeb.ObjectsControllerTest do
  use ArworldWeb.ConnCase

  alias Arworld.Object
  alias Arworld.Object.Objects

  @create_attrs %{
    direction: 42,
    height: 120.5,
    is_active: true,
    lat: 120.5,
    lng: 120.5,
    object_name: "some object_name",
    object_type: "some object_type"
  }
  @update_attrs %{
    direction: 43,
    height: 456.7,
    is_active: false,
    lat: 456.7,
    lng: 456.7,
    object_name: "some updated object_name",
    object_type: "some updated object_type"
  }
  @invalid_attrs %{direction: nil, height: nil, is_active: nil, lat: 999, lng: 999, object_name: nil, object_type: nil}

  def fixture(:objects) do
    {:ok, objects} = Object.create_objects(@create_attrs)
    objects
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all objects", %{conn: conn} do
      conn = get(conn, Routes.objects_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create objects" do
    test "renders objects when data is valid", %{conn: conn} do
      conn = post(conn, Routes.objects_path(conn, :create), objects: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.objects_path(conn, :show, id))

      assert %{
               "id" => id,
               "direction" => 42,
               "height" => 120.5,
               "is_active" => true,
               "lat" => 120.5,
               "lng" => 120.5,
               "object_name" => "some object_name",
               "object_type" => "some object_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.objects_path(conn, :create), objects: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update objects" do
    setup [:create_objects]

    test "renders objects when data is valid", %{conn: conn, objects: %Objects{id: id} = objects} do
      conn = put(conn, Routes.objects_path(conn, :update, objects), objects: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.objects_path(conn, :show, id))

      assert %{
               "id" => id,
               "direction" => 43,
               "height" => 456.7,
               "is_active" => false,
               "lat" => 456.7,
               "lng" => 456.7,
               "object_name" => "some updated object_name",
               "object_type" => "some updated object_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, objects: objects} do
      conn = put(conn, Routes.objects_path(conn, :update, objects), objects: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete objects" do
    setup [:create_objects]

    test "deletes chosen objects", %{conn: conn, objects: objects} do
      conn = delete(conn, Routes.objects_path(conn, :delete, objects))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.objects_path(conn, :show, objects))
      end
    end
  end

  defp create_objects(_) do
    objects = fixture(:objects)
    {:ok, objects: objects}
  end
end
