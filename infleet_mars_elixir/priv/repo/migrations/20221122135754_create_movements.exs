defmodule InfleetMarsElixir.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements) do
      add :terminals, :string, null: false
      add :completed, :boolean, default: false, null: false
      add :errorIndexes, {:array, :integer}
      add :lastIndex, :integer
      add :model_version, :string

      timestamps()
    end
  end
end
