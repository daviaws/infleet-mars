defmodule InfleetMarsElixir.Repo do
  use Ecto.Repo,
    otp_app: :infleet_mars_elixir,
    adapter: Ecto.Adapters.Postgres
end
