defmodule InfleetMarsElixir.Repo.Migrations.AddMovementsMovableFk do
  use Ecto.Migration

  def change do
    alter table(:movements) do
      add :movables_id, references(:movables, on_delete: :delete_all)
    end

    create index(:movements, [:movables_id])
  end
end
