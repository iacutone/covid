defmodule Covid.Questionnaires.Questionnaire do
  use Ecto.Schema
  import Ecto.Changeset

  alias Covid.Batteries.Battery
  alias Covid.Companies.Company
  alias Covid.Workers.Worker

  schema "questionnaires" do
    belongs_to :worker, Worker
    belongs_to :company, Company
    has_many :batteries, Battery

    timestamps()
  end

  @doc false
  def changeset(questionnaire, attrs) do
    questionnaire
    |> cast(attrs, [:worker_id, :company_id])
    |> validate_required([])
  end
end
