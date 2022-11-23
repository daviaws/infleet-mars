defmodule InfleetMarsElixirWeb.V1.MovementsView do
  use InfleetMarsElixirWeb, :view
  alias InfleetMarsElixirWeb.V1.MovementsView

  def render("index.json", %{movements: movements}) do
    %{data: render_many(movements, MovementsView, "movements.json")}
  end

  def render("show.json", %{movements: movements}) do
    %{data: render_one(movements, MovementsView, "movements.json")}
  end

  def render("movements.json", %{movements: movements}) do
    %{
      id: movements.id,
      terminals: movements.terminals,
      movables_id: movements.movables_id
    }
  end
end
