defmodule InfleetMarsElixir.Movement.MovementStatus do
  use Ecto.Schema
  import Ecto.Changeset

  alias InfleetMarsElixir.Movement.Movements

  def model_version(), do: InfleetMarsElixir.model_version(:movement, :movement_status)
  def status(:pending), do: -1
  def status(:done), do: 0

  schema "movements_statuses" do
    field :completed, :boolean, default: false
    field :index, :integer
    field :end_direction, Ecto.Enum, values: InfleetMarsElixir.enum(:direction)
    field :end_position_x, :integer
    field :end_position_y, :integer
    field :model_version, :string
    field :sent_at, :naive_datetime
    field :start_direction, Ecto.Enum, values: InfleetMarsElixir.enum(:direction)
    field :start_position_x, :integer
    field :start_position_y, :integer
    field :status_code, :integer
    field :status_message, :string
    field :terminal, Ecto.Enum, values: InfleetMarsElixir.enum(:movement)
    belongs_to :movements, Movements

    timestamps()
  end

  @all [
    :terminal,
    :completed,
    :index,
    :status_code,
    :status_message,
    :sent_at,
    :start_position_x,
    :start_position_y,
    :start_direction,
    :end_position_x,
    :end_position_y,
    :end_direction,
    :model_version
  ]
  @required [:terminal, :index, :model_version]

  @doc false
  def changeset(movement_status, attrs) do
    movement_status
    |> Map.put(:model_version, model_version())
    |> cast(attrs, @all)
    |> validate_required(@required)
  end
end
