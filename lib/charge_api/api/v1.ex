require Logger

defmodule ChargeApi.Api.V1 do
  def process_request(params) do
    case HTTPoison.get(construct_uri(params)) do
      { :ok, %{ status_code: 500, body: body } } ->
        Logger.error("Api.V1 got 500 for params #{inspect(params)}, response body: #{body}")
        { 500, %{ error: "internal_error" } }
      { :error, error} ->
        Logger.error("Api.V1 endpoint unavailable: #{inspect(error)}")
        { 500, %{ error: "internal_error" } }
      { :ok, %{ status_code: code, body: body } } ->
        { code, response(body) }
    end
  end

  defp response(body) do
    { :ok, result } = Poison.decode(body)
    case result do
      %{ "error" => msg } ->
        %{ error: msg }
      %{ "duration" => duration, "distance" => distance } ->
        ChargeApi.ChargeResolver.resolve(duration: duration, distance: distance)
    end
  end

  defp construct_uri(params) do
    query = URI.encode_query(params)
    to_string URI.merge(time_distance_api_endpoint(), "?#{query}")
  end

  defp time_distance_api_endpoint do
    Application.get_env(:charge_api, :time_distance_api_endpoint)
  end
end
