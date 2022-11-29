defmodule InfleetMarsElixirWeb.V1.MovementsController do
  use InfleetMarsElixirWeb, :controller

  alias InfleetMarsElixir.Movement
  alias InfleetMarsElixir.Movement.Movements

  action_fallback InfleetMarsElixirWeb.FallbackController

  def index(conn, _params) do
    movements = Movement.list_movements()
    render(conn, "index.json", movements: movements)
  end

  def create(conn, %{"movements" => movements_params}) do
    with {:ok, %Movements{} = movements} <- Movement.create_movements(movements_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.v1_movements_path(conn, :show, movements))
      |> render("show.json", movements: movements)
    end
  end

  def show(conn, %{"id" => id}) do
    movements = Movement.get_movements!(id)
    render(conn, "show.json", movements: movements)
  end

  def update(conn, %{"id" => id, "movements" => movements_params}) do
    movements = Movement.get_movements!(id)

    with {:ok, %Movements{} = movements} <- Movement.update_movements(movements, movements_params) do
      render(conn, "show.json", movements: movements)
    end
  end

  def delete(conn, %{"id" => id}) do
    movements = Movement.get_movements!(id)

    with {:ok, %Movements{}} <- Movement.delete_movements(movements) do
      send_resp(conn, :no_content, "")
    end
  end
end
