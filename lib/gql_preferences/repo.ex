defmodule UserPreferences.Repo do
  use Ecto.Repo,
    otp_app: :gql_preferences,
    adapter: Ecto.Adapters.Postgres
end
