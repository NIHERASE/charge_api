defmodule ChargeResolverTest do
  use ExUnit.Case
  doctest ChargeApi.ChargeResolver

  test "For 0 duration and distance minimal price is charged" do
    assert ChargeApi.ChargeResolver.resolve(duration: 0, distance: 0)
      == money_forms(charge(:min_charge))
  end

  test "Price is equal to serving_charge + per_km * km + per_minute * minutes" do
    price = charge(:serving_charge)
            |> Money.add(Money.multiply(charge(:per_minute), 60))
            |> Money.add(Money.multiply(charge(:per_km), 40))
    assert price > charge(:min_charge)
    assert ChargeApi.ChargeResolver.resolve(duration: 60 * 60, distance: 40_000)
      == money_forms(price)
  end

  defp money_forms(money) do
    %{ price: money.amount,
       price_str: Money.to_string(money, separator: "", delimeter: ".", symbol: false, symbol_space: false),
       price_str_human: Money.to_string(money) }
  end

  defp charge(charge_type) do
    charge = config()[charge_type] || raise("Charge type #{charge_type} is not defined")
    Money.new(charge)
  end
  defp config do
    Application.fetch_env!(:charge_api, ChargeApi.ChargeResolver)
  end
end
