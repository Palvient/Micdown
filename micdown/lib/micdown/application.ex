defmodule Micdown.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MicdownWeb.Telemetry,
      Micdown.Repo,
      {DNSCluster, query: Application.get_env(:micdown, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Micdown.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Micdown.Finch},
      # Start a worker by calling: Micdown.Worker.start_link(arg)
      # {Micdown.Worker, arg},
      # Start to serve requests, typically the last entry
      MicdownWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Micdown.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MicdownWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
