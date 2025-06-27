defmodule Micdown.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Micdown.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2025-06-09],
        email: "some email",
        hashed_password: "some hashed_password",
        username: "some username"
      })
      |> Micdown.Accounts.create_user()

    user
  end
end
