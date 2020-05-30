defmodule Covid.Workers.Worker do
  use Ecto.Schema
  import Ecto.Changeset

  alias Covid.Questionnaires.Questionnaire
  alias Covid.Companies.Company

  schema "workers" do
    field :current, :boolean, default: true
    field :name, :string

    has_one :company, Company

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [:name, :current])
    |> validate_required([:name, :current])
  end
end
