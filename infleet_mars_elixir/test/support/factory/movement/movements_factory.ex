defmodule InfleetMarsElixir.Movement.MovementsFactory do
  @moduledoc false

  alias InfleetMarsElixir.Movement.Movements

  defmacro __using__(_opts) do
    quote do
      def movements_factory do
        %Movements{
          model_version: InfleetMarsElixir.model_version(:movement, :movements),
          completed: false,
          terminals: "M",
          errorIndexes: [],
          lastIndex: -1
        }
      end
    end
  end
end
