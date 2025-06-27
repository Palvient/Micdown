defmodule Micdown.Repo do
  use Ecto.Repo,
    otp_app: :micdown,
    adapter: Ecto.Adapters.Postgres
end
