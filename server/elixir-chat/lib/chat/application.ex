defmodule Chat.Application do
  use Application

  def start(_type, _args) do
  children = [
    ChatWeb.Endpoint,
    Chat.Users  # Start user tracking agent
  ]

  opts = [strategy: :one_for_one, name: Chat.Supervisor]
  Supervisor.start_link(children, opts)
end

end
