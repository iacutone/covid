defmodule Covid.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :query, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
