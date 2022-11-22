defmodule InfleetMarsElixir.Repo.Migrations.CreateMovables do
  use Ecto.Migration

  def change do
    create table(:movables) do
      add :x, :integer
      add :y, :integer
      add :direction, :integer
      add :model_version, :string

      timestamps()
    end
  end
end
