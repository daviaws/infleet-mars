defmodule InfleetMarsElixirWeb.PageController do
  use InfleetMarsElixirWeb, :controller

  def index(conn, _params) do
    conn |> redirect(to: "/app")
  end

  def page(conn, _params) do
    html(conn, File.read!("./priv/static/index.html"))
  end
end
