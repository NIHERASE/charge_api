use Mix.Config

config :charge_api,
  cowboy_port: 4001,
  time_distance_api_endpoint: "http://localhost:4000/api/v1/get_time_distance"

config :logger, level: :info

config :money,
  default_currency: :RUB,
  separator: " ",
  delimeter: ",",
  symbol: true,
  symbol_on_right: true,
  symbol_space: true

config :charge_api, ChargeApi.ChargeResolver,
  serving_charge: 150_00,
  per_minute:     15_00,
  per_km:         38_00,
  min_charge:     300_00
