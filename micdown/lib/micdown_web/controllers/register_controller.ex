defmodule MicdownWeb.RegisterController do
  use MicdownWeb, :controller
  alias Micdown.Accounts.User
  alias Micdown.Repo

  # POST /register
  def create(conn, params) do
    IO.inspect(params, label: "Incoming Params")

    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        IO.puts("user: #{user.username} successfully registered")
        # Registration successful
        json(conn, %{
          id: user.id,
          username: user.username,
          email: user.email,
          birthdate: user.birthdate,
          inserted_at: user.inserted_at
        })

      {:error, changeset} ->
        # Convert errors to JSON-friendly format
        errors =
          Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", errors: errors})
    end
  end
end
