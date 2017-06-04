defmodule ChargeApi.Mixfile do
  use Mix.Project

  def project do
    [app: :charge_api,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {ChargeApi, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.1"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:money, "~> 1.2.1"}
    ]
  end
end
