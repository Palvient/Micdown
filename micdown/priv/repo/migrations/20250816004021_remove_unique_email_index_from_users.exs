defmodule Micdown.Repo.Migrations.RemoveUniqueEmailIndexFromUsers do
  use Ecto.Migration

  def change do
    drop_if_exists unique_index(:users, [:email])
  end
end
