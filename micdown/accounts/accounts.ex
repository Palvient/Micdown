defmodule Accounts do
  alias Micdown.Accounts.User

  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
