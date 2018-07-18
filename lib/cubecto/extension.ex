defmodule Cubecto.Extension do
  @moduledoc false
  @behaviour Postgrex.Extension

  @impl true
  def init(opts) do
    Keyword.get(opts, :decode_copy, :copy)
  end

  @impl true
  def matching(_), do: [type: "cube"]

  @impl true
  def format(_), do: :text

  @impl true
  def encode(_) do
    quote do
      bin when is_binary(bin) ->
        [<<byte_size(bin)::signed-size(32)>> | bin]
    end
  end

  @impl true
  def decode(:reference) do
    quote do
      <<len::signed-size(32), bin::binary-size(len)>> ->
        bin
    end
  end

  def decode(:copy) do
    quote do
      <<len::signed-size(32), bin::binary-size(len)>> ->
        :binary.copy(bin)
    end
  end
end
