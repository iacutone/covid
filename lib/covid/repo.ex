defmodule Covid.Repo do
  use Ecto.Repo,
    otp_app: :covid,
    adapter: Ecto.Adapters.Postgres
end
