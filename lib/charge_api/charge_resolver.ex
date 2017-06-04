defmodule ChargeApi.ChargeResolver do
  def resolve(duration: duration, distance: distance) do
    price = price(duration, distance)
    %{ price: price.amount,
       price_str: Money.to_string(price, separator: "", delimeter: ".", symbol: false, symbol_space: false),
       price_str_human: Money.to_string(price) }
  end

  defp price(duration, distance) do
    minutes = Float.ceil(duration/60.0)
    klicks  = Float.ceil(distance/1000.0)

    price = charge(:serving_charge)
            |> Money.add(Money.multiply(charge(:per_minute), minutes))
            |> Money.add(Money.multiply(charge(:per_km), klicks))

    if price > charge(:min_charge) do
      price
    else
      charge(:min_charge)
    end
  end

  defp charge(charge_type) do
    charge = config()[charge_type] || raise("Charge type #{charge_type} is not defined")
    Money.new(charge)
  end
  defp config do
    Application.fetch_env!(:charge_api, __MODULE__)
  end
end
