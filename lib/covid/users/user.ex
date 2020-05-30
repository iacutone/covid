defmodule Covid.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Covid.Users.User
  alias Covid.Companies.Company
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    # VIRTUAL FIELDS
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_one :company, Company

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> encrypt_password
    |> downcase_email
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

  defp encrypt_password(changeset) do
    password = get_field(changeset, :password)

    if password do
      hashed_password = Bcrypt.hashpwsalt(password)
      put_change(changeset, :encrypted_password, hashed_password)
    else
      changeset
    end
  end
end
