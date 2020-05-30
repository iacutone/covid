defmodule Covid.Repo.Migrations.CreateWorkers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION citext"

    create table(:workers) do
      add :name, :citext
      add :current, :boolean, default: true, null: false
      add :company_id, references(:companies)

      timestamps()
    end

  end
end
