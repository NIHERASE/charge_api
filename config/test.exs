use Mix.Config

config :charge_api,
  time_distance_api_endpoint: "http://localhost:4000/api/v1/get_time_distance"

config :charge_api, ChargeApi.ChargeResolver,
  serving_charge: 150_00,
  per_minute:     15_00,
  per_km:         38_00,
  min_charge:     300_00
