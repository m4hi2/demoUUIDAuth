defmodule DemoUUIDAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DemoUUIDAuthWeb.Telemetry,
      DemoUUIDAuth.Repo,
      {DNSCluster, query: Application.get_env(:demoUUIDAuth, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DemoUUIDAuth.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DemoUUIDAuth.Finch},
      # Start a worker by calling: DemoUUIDAuth.Worker.start_link(arg)
      # {DemoUUIDAuth.Worker, arg},
      # Start to serve requests, typically the last entry
      DemoUUIDAuthWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DemoUUIDAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoUUIDAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
