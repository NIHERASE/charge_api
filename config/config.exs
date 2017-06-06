use Mix.Config

import_config "#{Mix.env}.exs"

config :charge_api,
  cowboy_port: 4001

config :logger, level: :info

config :money,
  default_currency: :RUB,
  separator: " ",
  delimeter: ",",
  symbol: true,
  symbol_on_right: true,
  symbol_space: true
