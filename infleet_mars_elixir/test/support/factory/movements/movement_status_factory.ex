defmodule InfleetMarsElixir.Movements.MovementStatusFactory do
  @moduledoc false

  alias InfleetMarsElixir.Movement.MovementStatus

  defmacro __using__(_opts) do
    quote do
      def movement_status_factory do
        %MovementStatus{
          model_version: InfleetMarsElixir.model_version(:movement, :movement_status),
          completed: false,
          end_direction: 9,
          end_position_x: 0,
          end_position_y: 0,
          sent_at: NaiveDateTime.utc_now(),
          start_direction: 0,
          start_position_x: 0,
          start_position_y: 0,
          status_code: MovementStatus.status(:pending),
          status_message: nil,
          terminal: 0
        }
      end
    end
  end
end
