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
        # Add confirmation token & timestamp
        user =
          user
          |> generate_confirmation_token()
          |> Repo.update!()

        # Send confirmation email (implement this)
        Micdown.Email.confirmation_email(user)
        |> Micdown.Mailer.deliver()

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

  defp generate_confirmation_token(user) do
    token = :crypto.strong_rand_bytes(32) |> Base.url_encode64(padding: false)

    Ecto.Changeset.change(user,
      confirmation_token: token,
      confirmation_sent_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    )
  end
end
