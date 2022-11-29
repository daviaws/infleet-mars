defmodule InfleetMarsElixirWeb.MovementsControllerTest do
  use InfleetMarsElixirWeb.ConnCase

  alias InfleetMarsElixir.Movement.Movements

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movements", %{conn: conn} do
      conn = get(conn, Routes.v1_movements_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movements" do
    test "renders movements when data is valid", %{conn: conn} do
      %{id: movables_id} = insert(:movables)

      create_attrs = %{
        movables_id: movables_id,
        terminals: "EEDM"
      }

      conn = post(conn, Routes.v1_movements_path(conn, :create), movements: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.v1_movements_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "movables_id" => ^movables_id,
               "terminals" => "EEDM"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      invalid_attrs = %{terminals: "ASDF"}
      conn = post(conn, Routes.v1_movements_path(conn, :create), movements: invalid_attrs)

      assert json_response(conn, 422)["errors"] == %{
               "terminals" => ["must be valid movementEnum"]
             }
    end
  end

  describe "update movements" do
    setup [:create_movements]

    test "renders movements when data is valid", %{
      conn: conn,
      movements: %Movements{id: id} = movements
    } do
      %{id: movables_id} = insert(:movables)

      update_attrs = %{
        movables_id: movables_id,
        terminals: "MMM"
      }

      conn =
        put(conn, Routes.v1_movements_path(conn, :update, movements), movements: update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.v1_movements_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "movables_id" => ^movables_id,
               "terminals" => "MMM"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movements: movements} do
      invalid_attrs = %{terminals: "ASDF"}

      conn =
        put(conn, Routes.v1_movements_path(conn, :update, movements), movements: invalid_attrs)

      assert %{"terminals" => ["must be valid movementEnum"]} ==
               json_response(conn, 422)["errors"]
    end

    test "renders errors when movement_id does not exist", %{conn: conn, movements: movements} do
      invalid_movables_id_attrs = %{movables_id: 43, terminals: "M"}

      conn =
        put(conn, Routes.v1_movements_path(conn, :update, movements),
          movements: invalid_movables_id_attrs
        )

      assert json_response(conn, 422)["errors"] == %{"movables_id" => ["does not exist"]}
    end
  end

  describe "delete movements" do
    setup [:create_movements]

    test "deletes chosen movements", %{conn: conn, movements: movements} do
      conn = delete(conn, Routes.v1_movements_path(conn, :delete, movements))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.v1_movements_path(conn, :show, movements))
      end
    end
  end

  defp create_movements(_) do
    movable = insert(:movables)
    movements = insert(:movements)
    %{movable: movable, movements: movements}
  end
end
