defmodule InfleetMarsElixirWeb.V1.MovablesController do
  use InfleetMarsElixirWeb, :controller

  alias InfleetMarsElixir.Movement
  alias InfleetMarsElixir.Movement.Movables

  action_fallback InfleetMarsElixirWeb.FallbackController

  def index(conn, _params) do
    movables = Movement.list_movables()
    render(conn, "index.json", movables: movables)
  end

  def create(conn, %{"movables" => movables_params}) do
    with {:ok, %Movables{} = movables} <- Movement.create_movables(movables_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.v1_movables_path(conn, :show, movables))
      |> render("show.json", movables: movables)
    end
  end

  def show(conn, %{"id" => id}) do
    movables = Movement.get_movables!(id)
    render(conn, "show.json", movables: movables)
  end

  def update(conn, %{"id" => id, "movables" => movables_params}) do
    movables = Movement.get_movables!(id)

    with {:ok, %Movables{} = movables} <- Movement.update_movables(movables, movables_params) do
      render(conn, "show.json", movables: movables)
    end
  end

  def delete(conn, %{"id" => id}) do
    movables = Movement.get_movables!(id)

    with {:ok, %Movables{}} <- Movement.delete_movables(movables) do
      send_resp(conn, :no_content, "")
    end
  end
end
