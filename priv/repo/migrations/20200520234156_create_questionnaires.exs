defmodule Covid.Repo.Migrations.CreateQuestionnaires do
  use Ecto.Migration

  def change do
    create table(:questionnaires) do
      add :worker_id, references(:workers), null: false
      add :company_id, references(:companies)

      timestamps()
    end

  end
end
