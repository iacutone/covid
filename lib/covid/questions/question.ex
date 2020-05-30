defmodule Covid.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :active, :boolean, default: false
    field :query, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:query, :active])
    |> validate_required([:query, :active])
  end
end
