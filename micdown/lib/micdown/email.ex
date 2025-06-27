defmodule Micdown.Email do
  import Swoosh.Email

  def confirmation_email(user) do
    new()
    |> to({user.username, user.email})
    |> from({"Micdown", "noreply@micdown.com"})
    |> subject("Confirm your email")
    |> text_body("Visit http://localhost:4000/confirm?token=#{user.confirmation_token} to confirm your email.")
    |> html_body("""
    <p>Welcome #{user.username}, click <a href="http://localhost:4000/confirm?token=#{user.confirmation_token}">here</a> to confirm your email.</p>
    """)
  end
end
