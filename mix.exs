defmodule Gaston.Mixfile do
  use Mix.Project

  def project do
    [app: :gaston,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :slack, :postgrex, :ecto],
     mod: {Gaston, []}]
  end

  defp deps do
    [{:slack, "~> 0.7.1"},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client"},
     {:postgrex, ">= 0.0.0"},
     {:ecto, "~> 2.0.0"}]
  end
end
