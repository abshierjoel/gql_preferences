defmodule UserPreferencesWeb.Resolvers.Preferences do
  alias UserPreferences.{Repo, Preferences}

  def get_preferences(parent, _args, _) do
    ActivityMonitor.update_resolver_activity("get_preferences")

    Preferences
    |> Repo.get_by(user_id: parent.id)
    |> then(&{:ok, &1})
  end

  def create_preferences(args) do
    %Preferences{}
    |> Preferences.changeset(args)
    |> Repo.insert()
  end

  def update_preferences_by_id(_, args, _) do
    ActivityMonitor.update_resolver_activity("update_preferences_by_id")

    {:ok, prefs} =
      Repo.get_by(Preferences, user_id: args.user_id)
      |> Preferences.changeset(args)
      |> Repo.update()

    Absinthe.Subscription.publish(UserPreferencesWeb.Endpoint, prefs,
      updated_user_preferences: "*"
    )

    {:ok, prefs}
  end
end
