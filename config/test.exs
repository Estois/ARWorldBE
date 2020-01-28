use Mix.Config

# Configure your database
config :arworld, Arworld.Repo,
  username: "postgres",
  password: "postgres",
  database: "arworld_test",
  hostname: "localhost",
  types: Arworld.PostgresTypes,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :arworld, ArworldWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
