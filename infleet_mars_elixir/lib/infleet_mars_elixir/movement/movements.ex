defmodule InfleetMarsElixir.Movement.Movements do
  use Ecto.Schema
  import Ecto.Changeset

  alias InfleetMarsElixir.Movement.MovementStatus

  def model_version(), do: InfleetMarsElixir.model_version(:movement, :movements)

  schema "movements" do
    field :completed, :boolean, default: false
    field :errorIndexes, {:array, :integer}
    field :lastIndex, :integer
    field :terminals, :string
    field :model_version, :string
    has_many :statuses, MovementStatus

    timestamps()
  end

  @all [:terminals, :completed, :lastIndex, :errorIndexes]
  @required [:terminals, :model_version]

  @doc false
  def changeset(movements, attrs) do
    movements
    |> Map.put(:model_version, model_version())
    |> cast(attrs, @all)
    |> validate_required(@required)
    |> validate_format(:terminals, InfleetMarsElixir.enum_format(:movement),
      message: "must be valid movementEnum"
    )
  end
end
