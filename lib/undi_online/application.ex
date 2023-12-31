defmodule UndiOnline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UndiOnlineWeb.Telemetry,
      # Start the Ecto repository
      UndiOnline.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: UndiOnline.PubSub},
      # Start Finch
      {Finch, name: UndiOnline.Finch},
      # Start the Endpoint (http/https)
      UndiOnlineWeb.Endpoint,
      # Start a worker by calling: UndiOnline.Worker.start_link(arg)
      # {UndiOnline.Worker, arg}
      {Oban, oban_config()},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UndiOnline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UndiOnlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.fetch_env!(:undi_online, Oban)
  end
end
