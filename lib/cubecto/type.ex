defmodule Cubecto.Type do
  @moduledoc false
  @behaviour Ecto.Type

  @impl true
  def type, do: :cube

  @impl true
  def cast(list) when is_list(list) do
    {:ok, list}
  end

  def cast(_), do: :error

  @impl true
  def load(string) do
    list =
      string
      |> String.trim_leading("(")
      |> String.trim_trailing(")")
      |> String.split(", ")
      |> Enum.map(&parse_value/1)

    {:ok, list}
  end

  @impl true
  def dump(list) when is_list(list) do
    list =
      list
      |> Enum.map(&to_string/1)
      |> Enum.join(", ")

    {:ok, list}
  end

  def dump(_), do: :error

  @impl true
  def embed_as(_), do: :self

  @impl true
  def equal?(term1, term2), do: term1 == term2

  defp parse_value(val) do
    {float, _} = Float.parse(val)
    int = trunc(float)
    if float == int, do: int, else: float
  end
end
