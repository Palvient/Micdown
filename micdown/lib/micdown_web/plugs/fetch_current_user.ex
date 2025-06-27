defmodule MicdownWeb.Plugs.FetchCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # Example: assign nil or fetch user from session/token here
    assign(conn, :current_user, nil)
  end
end
