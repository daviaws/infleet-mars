defmodule InfleetMarsElixir.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: InfleetMarsElixir.Repo

  use InfleetMarsElixir.Movement.MovablesFactory
  use InfleetMarsElixir.Movement.MovementsFactory
  use InfleetMarsElixir.Movement.MovementStatusFactory
end
