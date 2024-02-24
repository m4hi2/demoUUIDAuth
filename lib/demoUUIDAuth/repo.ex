defmodule DemoUUIDAuth.Repo do
  use Ecto.Repo,
    otp_app: :demoUUIDAuth,
    adapter: Ecto.Adapters.Postgres
end
