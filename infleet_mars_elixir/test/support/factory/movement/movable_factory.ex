defmodule InfleetMarsElixir.Movement.MovablesFactory do
  @moduledoc false

  alias InfleetMarsElixir.Movement.Movables

  defmacro __using__(_opts) do
    quote do
      def movables_factory do
        %Movables{
          model_version: InfleetMarsElixir.model_version(:movement, :movables),
          direction: 0,
          x: 0,
          y: 0
        }
      end
    end
  end
end
