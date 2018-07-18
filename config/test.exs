use Mix.Config

config :cubecto, Cubecto.Test.Repo,
  database: "cubecto_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  adapter: Ecto.Adapters.Postgres,
  types: Cubecto.Test.PostgrexTypes

config :logger, level: :warn
