import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :infleet_mars_elixir, InfleetMarsElixir.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "db",
  database: "infleet_mars_elixir_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :infleet_mars_elixir, InfleetMarsElixirWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MwUFTbjNBXKlXA/9vaGJ91esq5A1pe8COAFObDUsdE3x//0Wf9CDQQDoQWIX3b1C",
  server: false

# In test we don't send emails.
config :infleet_mars_elixir, InfleetMarsElixir.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
