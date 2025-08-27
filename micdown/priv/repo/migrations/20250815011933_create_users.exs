defmodule Micdown.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :birthdate, :date
      add :hashed_password, :string, null: false

      timestamps(type: :utc_datetime)
    end

    # Optional: enforce unique usernames and emails
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
