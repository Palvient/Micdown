defmodule MicdownWeb.SessionController do
  use MicdownWeb, :controller
  alias Micdown.Accounts
  alias Micdown.Repo
  alias Micdown.Accounts.User
  alias Pbkdf2

  def create(conn, %{"username" => username, "password" => password}) do
    user = Repo.get_by(User, username: username)

    cond do
      user == nil ->
        IO.puts("Login attempt failed: username '#{username}' not found")
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Username not found"})

      !Pbkdf2.verify_pass(password, user.hashed_password) ->
        IO.puts("Login attempt failed: password for username '#{username}' incorrect")
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Password incorrect"})

      true ->
        # Login successful
        IO.puts("Login successful: #{username}")
        json(conn, %{username: user.username})
    end
  end
end
