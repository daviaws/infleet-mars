defmodule InfleetMarsElixir do
  @moduledoc """
  InfleetMarsElixir keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def model_version(context, schema) do
    Application.get_env(:infleet_mars_elixir, :models_versions)[context][schema]
  end
end
