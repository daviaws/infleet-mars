defmodule InfleetMarsElixirWeb.MovablesControllerTest do
  use InfleetMarsElixirWeb.ConnCase

  alias InfleetMarsElixir.Movement.Movables

  import InfleetMarsElixir.Factory

  @create_attrs %{
    direction: "N",
    x: 42,
    y: 42
  }
  @update_attrs %{
    direction: "S",
    x: 43,
    y: 43
  }
  @invalid_attrs %{direction: "invalid", x: nil, y: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movables", %{conn: conn} do
      conn = get(conn, Routes.v1_movables_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movables" do
    test "renders movables when data is valid", %{conn: conn} do
      conn = post(conn, Routes.v1_movables_path(conn, :create), movables: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.v1_movables_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "direction" => "N",
               "x" => 42,
               "y" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.v1_movables_path(conn, :create), movables: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movables" do
    setup [:create_movables]

    test "renders movables when data is valid", %{
      conn: conn,
      movables: %Movables{id: id} = movables
    } do
      conn = put(conn, Routes.v1_movables_path(conn, :update, movables), movables: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.v1_movables_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "direction" => "S",
               "x" => 43,
               "y" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movables: movables} do
      conn = put(conn, Routes.v1_movables_path(conn, :update, movables), movables: @invalid_attrs)

      assert json_response(conn, 422)["errors"] == %{
               "direction" => ["is invalid"],
               "x" => ["can't be blank"],
               "y" => ["can't be blank"]
             }
    end
  end

  describe "delete movables" do
    setup [:create_movables]

    test "deletes chosen movables", %{conn: conn, movables: movables} do
      conn = delete(conn, Routes.v1_movables_path(conn, :delete, movables))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.v1_movables_path(conn, :show, movables))
      end
    end
  end

  defp create_movables(_) do
    movables = insert(:movables)
    %{movables: movables}
  end
end
