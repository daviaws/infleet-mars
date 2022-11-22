defmodule InfleetMarsElixir.Movement.Movables do
  use Ecto.Schema
  import Ecto.Changeset

  alias InfleetMarsElixir.Movement.Movements

  def model_version(), do: InfleetMarsElixir.model_version(:movement, :movables)

  schema "movables" do
    field :direction, Ecto.Enum, values: InfleetMarsElixir.enum(:direction)
    field :model_version, :string
    field :x, :integer
    field :y, :integer
    has_many :movements, Movements

    timestamps()
  end

  @all [:x, :y, :direction]
  @required @all ++ [:model_version]

  @doc false
  def changeset(movables, attrs) do
    movables
    |> Map.put(:model_version, model_version())
    |> cast(attrs, @all)
    |> validate_required(@required)
  end
end
