defmodule Dockview.Repo do
  use Ecto.Repo,
    otp_app: :dockview,
    adapter: Ecto.Adapters.Postgres
end
