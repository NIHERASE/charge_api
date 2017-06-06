defmodule ChargeApi.Api.V1Test do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ChargeApi.Api.V1

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end

  test "Returns price for the ride" do
    use_cassette "v1/success" do
      result = ChargeApi.Api.V1.process_request(origin_lat: 40, origin_lon: 40.1, dest_lat: 40, dest_lon: 40.1)
      assert result == { 200, %{price: 30000, price_str: "300.00", price_str_human: "300,00 руб"} }
    end
  end

  test "Passes no_route error" do
    use_cassette "v1/no_route" do
      result = ChargeApi.Api.V1.process_request(origin_lat: 0, origin_lon: 0, dest_lat: 80, dest_lon: 170)
      assert result == { 200, %{ error: "no_route" } }
    end
  end

  test "Passes internal_error error" do
    use_cassette "v1/internal_error" do
      result = ChargeApi.Api.V1.process_request(origin_lat: 40, origin_lon: 40.1, dest_lat: 40, dest_lon: 40.1)
      assert result == { 500, %{ error: "internal_error" } }
    end
  end

  test "Returns internal_error if time_distance_api is not available" do
    use_cassette "v1/not_available" do
      result = ChargeApi.Api.V1.process_request(origin_lat: 40, origin_lon: 40.1, dest_lat: 40, dest_lon: 40.1)
      assert result == { 500, %{ error: "internal_error" } }
    end
  end
end
