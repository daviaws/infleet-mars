defmodule InfleetMarsElixirWeb.V1.WorldController do
  use InfleetMarsElixirWeb, :controller

  alias InfleetMarsElixir.Movement

  action_fallback InfleetMarsElixirWeb.FallbackController

  def index(conn, _params) do
    render(conn, "world.json", world: Movement.world())
  end

  def update(conn, %{"world" => params}) do
    x = params["x"]
    y = params["y"]

    with true <- is_integer(x) || "not an integer",
         true <- is_integer(y) || "not an integer",
         {:ok, world} <- Movement.set_world(x, y) do
          render(conn, "show.json", world: world)
    end
  end
end
