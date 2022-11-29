defmodule InfleetMarsElixirWeb.V1.MovablesView do
  use InfleetMarsElixirWeb, :view
  alias InfleetMarsElixirWeb.V1.MovablesView

  def render("index.json", %{movables: movables}) do
    %{data: render_many(movables, MovablesView, "movables.json")}
  end

  def render("show.json", %{movables: movables}) do
    %{data: render_one(movables, MovablesView, "movables.json")}
  end

  def render("movables.json", %{movables: movables}) do
    %{
      id: movables.id,
      x: movables.x,
      y: movables.y,
      direction: movables.direction
    }
  end
end
