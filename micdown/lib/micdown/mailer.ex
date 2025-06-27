defmodule Micdown.Mailer do
  use Swoosh.Mailer, otp_app: :micdown

  def send_confirmation_email(user) do
    user
    |> Micdown.Email.confirmation_email()
    |> deliver()
  end
end
