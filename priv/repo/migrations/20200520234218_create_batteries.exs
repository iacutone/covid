defmodule Covid.Repo.Migrations.CreateBatteries do
  use Ecto.Migration

  def change do
    create table(:batteries) do
      add :question_id, references(:questions), null: false
      add :questionnaire_id, references(:questionnaires), null: false
      add :verified, :boolean, default: false

      timestamps()
    end

  end
end
