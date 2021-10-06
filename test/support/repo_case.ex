defmodule UserPreferences.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias UserPreferences.Repo

      import Ecto
      import Ecto.Query
      import UserPreferences.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(UserPreferences.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(UserPreferences.Repo, {:shared, self()})
    end

    :ok
  end
end
