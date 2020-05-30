defmodule Covid.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :user_id, references(:users)

      timestamps()
    end

  end
end
