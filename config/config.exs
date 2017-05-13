# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :polcom,
  ecto_repos: [Polcom.Repo]

# Configures the endpoint
config :polcom, Polcom.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JGVEaffcmueFIANi/pmCIywYC3rtq9Ijsiun9+JauLptIJtbMD4NQ/MqLvAGFeMp",
  render_errors: [view: Polcom.ErrorView, accepts: ~w(json)],
  pubsub: [name: Polcom.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
