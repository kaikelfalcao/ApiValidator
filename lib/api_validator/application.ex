defmodule ApiValidator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ApiValidator.Worker.start_link(arg)
      # {ApiValidator.Worker, arg}
      {Plug.Cowboy,
       scheme: :http,
       plug: ApiValidator.Router,
       options: [port: Application.get_env(:api_validator, :port)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiValidator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
