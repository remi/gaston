# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Slack API token
config :slack, api_token: System.get_env("SLACK_API_TOKEN")

# Channels to listen to
config :gaston, channels: System.get_env("GASTON_CHANNELS") |> String.split(",")

# Database
config :gaston, ecto_repos: [Gaston.Repo]
config :gaston, Gaston.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL")
