defmodule InfleetMarsElixir.Repo.Migrations.AddMovementsStatusMovementsFk do
  use Ecto.Migration

  def change do
    alter table(:movements_statuses) do
      add :index, :integer, null: false
      add :movements_id, references(:movements, on_delete: :delete_all)
    end

    create index(:movements_statuses, [:movements_id])
  end
end
