defmodule Covid.Users do

  import Ecto.Query, warn: false
  alias Covid.Repo
  alias Covid.Users.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_by_email(email) when is_nil(email) do
    nil
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
