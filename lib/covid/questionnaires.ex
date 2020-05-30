defmodule Covid.Questionnaires do
  @moduledoc """
  The Questionnaires context.
  """

  import Ecto.Query, warn: false
  alias Covid.Repo

  alias Covid.Questionnaires.Questionnaire

  @doc """
  Returns the list of questionnaires.

  ## Examples

      iex> list_questionnaires()
      [%Questionnaire{}, ...]

  """
  def list_questionnaires do
    Repo.all(Questionnaire)
  end

  @doc """
  Gets a single questionnaire.

  Raises `Ecto.NoResultsError` if the Questionnaire does not exist.

  ## Examples

      iex> get_questionnaire!(123)
      %Questionnaire{}

      iex> get_questionnaire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_questionnaire!(id), do: Repo.get!(Questionnaire, id)

  @doc """
  Creates a questionnaire.

  ## Examples

      iex> create_questionnaire(%{field: value})
      {:ok, %Questionnaire{}}

      iex> create_questionnaire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_questionnaire(attrs \\ %{}) do
    %Questionnaire{}
    |> Questionnaire.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a questionnaire.

  ## Examples

      iex> update_questionnaire(questionnaire, %{field: new_value})
      {:ok, %Questionnaire{}}

      iex> update_questionnaire(questionnaire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_questionnaire(%Questionnaire{} = questionnaire, attrs) do
    questionnaire
    |> Questionnaire.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a questionnaire.

  ## Examples

      iex> delete_questionnaire(questionnaire)
      {:ok, %Questionnaire{}}

      iex> delete_questionnaire(questionnaire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_questionnaire(%Questionnaire{} = questionnaire) do
    Repo.delete(questionnaire)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking questionnaire changes.

  ## Examples

      iex> change_questionnaire(questionnaire)
      %Ecto.Changeset{data: %Questionnaire{}}

  """
  def change_questionnaire(%Questionnaire{} = questionnaire, attrs \\ %{}) do
    Questionnaire.changeset(questionnaire, attrs)
  end
end
