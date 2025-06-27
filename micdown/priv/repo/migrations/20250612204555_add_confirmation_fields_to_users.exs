defmodule Micdown.Repo.Migrations.AddConfirmationFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :confirmation_token, :string
      add :confirmation_sent_at, :naive_datetime
      add :confirmed_at, :naive_datetime
    end
  end
end
