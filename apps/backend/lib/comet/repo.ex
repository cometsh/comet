defmodule Comet.Repo do
  use Ecto.Repo,
    otp_app: :comet,
    adapter: Ecto.Adapters.Postgres
end
