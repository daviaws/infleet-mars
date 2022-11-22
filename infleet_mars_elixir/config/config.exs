# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :infleet_mars_elixir,
  ecto_repos: [InfleetMarsElixir.Repo]

# e.g InfleetMarsElixir.model_version(:movement, :movement_status)
config :infleet_mars_elixir,
  models_versions: [
    movement: [
      movables: "1.0",
      movements: "1.0",
      movement_status: "1.0"
    ]
  ]

# Configures the endpoint
config :infleet_mars_elixir, InfleetMarsElixirWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: InfleetMarsElixirWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: InfleetMarsElixir.PubSub,
  live_view: [signing_salt: "YvZdAmV9"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :infleet_mars_elixir, InfleetMarsElixir.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
