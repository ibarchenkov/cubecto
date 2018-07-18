defmodule Cubecto.TypeTest do
  use ExUnit.Case, async: true
  alias Cubecto.Test.Repo
  alias Cubecto.Test.CubectoSchema

  setup _ do
    {:ok, pid} =
      Postgrex.start_link(
        hostname: "localhost",
        username: "postgres",
        database: "cubecto_test",
        types: Cubecto.Test.PostgrexTypes
      )

    {:ok, _} = Postgrex.query(pid, "DROP TABLE IF EXISTS cubes", [])

    {:ok, _} = Postgrex.query(pid, "CREATE EXTENSION IF NOT EXISTS cube", [])

    {:ok, _} = Postgrex.query(pid, "CREATE TABLE cubes(id serial primary key, cube cube)", [])

    {:ok, _} = Repo.start_link()
    :ok
  end

  test "insert should work" do
    assert %{cube: [1, 2.0, -3, 0.1234]} =
             Repo.insert!(%CubectoSchema{cube: [1, 2.0, -3, 0.1234]})

    assert %{cube: [1, 2, -3, 0.1234]} = Repo.one(CubectoSchema)
  end

  test "update should work" do
    record = Repo.insert!(%CubectoSchema{cube: [1, 2.0, -3, 0.1234]})
    updated_record = %{record | cube: [-0.321, 9_999 | record.cube]}

    assert %{cube: [-0.321, 9999, 1, 2.0, -3, 0.1234]} =
             Repo.update!(Ecto.Changeset.change(updated_record))
  end
end
