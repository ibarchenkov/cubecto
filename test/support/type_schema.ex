defmodule Cubecto.Test.CubectoSchema do
  use Ecto.Schema

  schema "cubes" do
    field(:cube, Cubecto.Type)
  end
end
