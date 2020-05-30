defmodule Covid.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Covid.Questionnaires.Questionnaire
  alias Covid.Users.User
  alias Covid.Workers.Worker

  schema "companies" do
    field :name, :string
    belongs_to :user, User
    has_many :workers, Worker
    has_many :questionnaires, Questionnaire

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
