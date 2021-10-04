defmodule UserPreferencesWeb.Resolvers.Preferences do
  alias UserPreferences.{Repo, Preferences}

  def get_preferences(parent, _args, _) do
    Preferences
    |> Repo.get_by(user_id: parent.id)
    |> then(&{:ok, &1})
  end

  def update_preferences_by_id(_, args, _) do
    Repo.get_by(Preferences, user_id: args.user_id)
    |> Preferences.changeset(args)
    |> Repo.update()
  end
end
