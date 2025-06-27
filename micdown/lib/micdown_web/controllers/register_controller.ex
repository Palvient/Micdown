defmodule MicdownWeb.RegisterController do
  use MicdownWeb, :controller
  alias Micdown.Accounts.User
  alias Micdown.Repo

  def create(conn, params) do
    IO.inspect(params, label: "Incoming Params")

    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        user = generate_confirmation_token(user) |> Repo.update!()

        # Send confirmation email (you'll implement this)
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
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", errors: changeset.errors})
    end
  end

  defp generate_confirmation_token(user) do
    token = :crypto.strong_rand_bytes(32) |> Base.url_encode64(padding: false)
    changeset = Ecto.Changeset.change(user,
      confirmation_token: token,
      confirmation_sent_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    )
    changeset
  end
end
