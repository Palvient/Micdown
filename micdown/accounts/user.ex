defmodule Micdown.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pbkdf2

  schema "users" do
    field :username, :string
    field :email, :string
    field :birthdate, :date
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime
    field :confirmation_token, :string
    field :confirmation_sent_at, :naive_datetime
  # ... your other fields

  timestamps()
  end




  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :birthdate, :password])
    |> validate_required([:username, :email, :birthdate, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :hashed_password, Pbkdf2.hash_pwd_salt(password))
    end
  end
end
