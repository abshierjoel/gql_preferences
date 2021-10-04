defmodule UserPreferences.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Supervisor.Spec
  alias ActivityServer

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      UserPreferences.Repo,
      # Start the Telemetry supervisor
      UserPreferencesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: UserPreferences.PubSub},
      # Start the Endpoint (http/https)
      UserPreferencesWeb.Endpoint,
      # Start a worker by calling: UserPreferences.Worker.start_link(arg)
      # {UserPreferences.Worker, arg}
      ActivityServer,
      {Absinthe.Subscription, UserPreferencesWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UserPreferences.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UserPreferencesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
