defmodule InfleetMarsElixir.Movements.MovementStatusFactory do
  @moduledoc false

  alias InfleetMarsElixir.Movement.MovementStatus
  alias InfleetMarsElixir.Random

  defmacro __using__(_opts) do
    quote do
      def movement_status_factory do
        %MovementStatus{
          model_version: InfleetMarsElixir.model_version(:movement, :movement_status),
          completed: false,
          end_direction: nil,
          end_position_x: nil,
          end_position_y: nil,
          sent_at: NaiveDateTime.utc_now(),
          start_direction: InfleetMarsElixir.enum_values(:direction) |> Random.pick(),
          start_position_x: 0,
          start_position_y: 0,
          status_code: MovementStatus.status(:pending),
          status_message: nil,
          terminal: InfleetMarsElixir.enum_values(:movement) |> InfleetMarsElixir.Random.pick()
        }
      end
    end
  end
end
