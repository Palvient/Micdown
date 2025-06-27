defmodule MicdownWeb.ConfirmationController do
  use MicdownWeb, :controller
  alias Micdown.Repo
  alias Micdown.Accounts.User

  def confirm_email(conn, %{"token" => token}) do
    user = Repo.get_by(User, confirmation_token: token)

    cond do
      user == nil ->
        conn
        |> put_flash(:error, "Invalid or expired confirmation token.")
        |> redirect(to: "/")

      user.confirmed_at != nil ->
        conn
        |> put_flash(:info, "Your email is already confirmed.")
        |> redirect(to: "/")

      true ->
        user
        |> Ecto.Changeset.change(%{confirmed_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), confirmation_token: nil})
        |> Repo.update!()

        conn
        |> put_flash(:info, "Email confirmed successfully!")
        |> redirect(to: "/login")
    end
  end
end
