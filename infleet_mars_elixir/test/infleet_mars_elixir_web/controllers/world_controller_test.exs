defmodule InfleetMarsElixirWeb.WorldControllerTest do
  use InfleetMarsElixirWeb.ConnCase

  alias InfleetMarsElixir.Movement

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all worlds", %{conn: conn} do
      Movement.set_world(5, 5)
      conn = get(conn, Routes.v1_world_path(conn, :index))
      assert json_response(conn, 200) == %{"x" => 5, "y" => 5}
    end
  end

  describe "update world" do
    test "renders world when data is valid", %{conn: conn} do
      conn =
        put(conn, Routes.v1_world_path(conn, :update, "global"), world: %{"x" => 10, "y" => 10})

      json_response(conn, 200)

      conn = get(conn, Routes.v1_world_path(conn, :index))

      assert %{
               "x" => 10,
               "y" => 10
             } = json_response(conn, 200)
    end
  end
end
