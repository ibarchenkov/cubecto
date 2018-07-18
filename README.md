# Cubecto

Cubecto adds a [`Postgrex.Extension`][1] and [`Ecto.Type`][2] definitions
for the datatypes defined in the [`cube`][3] PostgreSQL module.

## Installation

**Add the package to your Mixfile**

```elixir
defp deps do
  [{:cubecto, "~> 0.1.0"}]
end
```


**Add Cubecto.Extension to the Postgrex types file somewhere in lib/my_app/**

```elixir
Postgrex.Types.define(
  MyApp.PostgrexTypes,
  [Cubecto.Extension] ++ Ecto.Adapters.Postgres.extensions()
)
```

**Configure Repo to use custom Postgrex types in config/config.exs**

```elixir
config :my_app, MyApp.Repo,
  types: MyApp.PostgrexTypes
```

**Create the cube extension in the database**

```elixir
defmodule MyApp.Repo.Migrations.CreateCubeExtension do
  use Ecto.Migration

  def change do
    execute(
      "CREATE EXTENSION IF NOT EXISTS cube",
      "DROP EXTENSION IF EXISTS cube"
    )
  end
end
```

## Usage

**Add a column with the cube datatype to a table**

```elixir
defmodule MyApp.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table("users") do
      add :cube, :cube
      # other fields
    end
  end
end
```

**Use Cubecto.Type for the cube field in an Ecto.Schema module**

```elixir
defmodule MyApp.Accounts.User do
  use Ecto.Schema

  schema "users" do
    field :cube, Cubecto.Type
    # other fields
  end
end
```

[1]: http://hexdocs.pm/postgrex/Postgrex.Extension.html
[2]: http://hexdocs.pm/ecto/Ecto.Type.html
[3]: https://www.postgresql.org/docs/current/static/cube.html
