defmodule InfleetMarsElixir.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: InfleetMarsElixir.Repo

  # use InfleetMarsElixir.Movements.MovablesFactory
  # use InfleetMarsElixir.Movements.MovementsFactory
  use InfleetMarsElixir.Movements.MovementStatusFactory
end
