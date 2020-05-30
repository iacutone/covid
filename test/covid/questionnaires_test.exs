defmodule Covid.QuestionnairesTest do
  use Covid.DataCase

  alias Covid.Questionnaires

  describe "questionnaires" do
    alias Covid.Questionnaires.Questionnaire

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def questionnaire_fixture(attrs \\ %{}) do
      {:ok, questionnaire} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Questionnaires.create_questionnaire()

      questionnaire
    end

    test "list_questionnaires/0 returns all questionnaires" do
      questionnaire = questionnaire_fixture()
      assert Questionnaires.list_questionnaires() == [questionnaire]
    end

    test "get_questionnaire!/1 returns the questionnaire with given id" do
      questionnaire = questionnaire_fixture()
      assert Questionnaires.get_questionnaire!(questionnaire.id) == questionnaire
    end

    test "create_questionnaire/1 with valid data creates a questionnaire" do
      assert {:ok, %Questionnaire{} = questionnaire} = Questionnaires.create_questionnaire(@valid_attrs)
    end

    test "create_questionnaire/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questionnaires.create_questionnaire(@invalid_attrs)
    end

    test "update_questionnaire/2 with valid data updates the questionnaire" do
      questionnaire = questionnaire_fixture()
      assert {:ok, %Questionnaire{} = questionnaire} = Questionnaires.update_questionnaire(questionnaire, @update_attrs)
    end

    test "update_questionnaire/2 with invalid data returns error changeset" do
      questionnaire = questionnaire_fixture()
      assert {:error, %Ecto.Changeset{}} = Questionnaires.update_questionnaire(questionnaire, @invalid_attrs)
      assert questionnaire == Questionnaires.get_questionnaire!(questionnaire.id)
    end

    test "delete_questionnaire/1 deletes the questionnaire" do
      questionnaire = questionnaire_fixture()
      assert {:ok, %Questionnaire{}} = Questionnaires.delete_questionnaire(questionnaire)
      assert_raise Ecto.NoResultsError, fn -> Questionnaires.get_questionnaire!(questionnaire.id) end
    end

    test "change_questionnaire/1 returns a questionnaire changeset" do
      questionnaire = questionnaire_fixture()
      assert %Ecto.Changeset{} = Questionnaires.change_questionnaire(questionnaire)
    end
  end
end
