defmodule ChargeApi do
  require Logger

  def start(_type, _args) do
    port = Application.get_env(:charge_api, :cowboy_port, 8080)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, ChargeApi.HTTPRouter, [], [port: port])
    ]

    Logger.info "Started application on port: #{port}"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
