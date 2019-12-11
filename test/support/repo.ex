defmodule Cubecto.Test.Repo do
  use Ecto.Repo,
    otp_app: :cubecto,
    adapter: Ecto.Adapters.Postgres
end
