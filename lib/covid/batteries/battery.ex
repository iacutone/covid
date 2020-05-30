defmodule Covid.Batteries.Battery do
  use Ecto.Schema
  import Ecto.Changeset

  alias Covid.Questions.Question
  alias Covid.Questionnaires.Questionnaire

  schema "batteries" do
    field :verified, :boolean

    belongs_to :question, Question
    belongs_to :questionnaire, Questionnaire

    timestamps()
  end

  @doc false
  def changeset(battery, attrs) do
    battery
    |> cast(attrs, [:question_id, :questionnaire_id, :verified])
    |> validate_required([])
  end
end
