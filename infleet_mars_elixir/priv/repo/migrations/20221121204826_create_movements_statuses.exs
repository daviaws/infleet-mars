defmodule InfleetMarsElixir.Repo.Migrations.CreateMovementsStatuses do
  use Ecto.Migration

  # @ InfleetMarsElixir.Movement.MovementStatus.status(:pending)
  @pending_status -1

  def change do
    create table(:movements_statuses) do
      add :terminal, :integer, null: false
      add :completed, :boolean, default: false, null: false
      add :status_code, :integer, default: @pending_status, null: false
      add :status_message, :string
      add :sent_at, :naive_datetime
      add :start_position_x, :integer
      add :start_position_y, :integer
      add :start_direction, :integer
      add :end_position_x, :integer
      add :end_position_y, :integer
      add :end_direction, :integer
      add :model_version, :string

      timestamps()
    end
  end
end
