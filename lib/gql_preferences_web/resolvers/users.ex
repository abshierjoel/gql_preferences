defmodule UserPreferencesWeb.Resolvers.Users do
  alias UserPreferences.{Repo, User}
  alias UserPreferencesWeb.Resolvers

  def get_user_by_id(_parent, args, _res) do
    ActivityMonitor.update_resolver_activity("get_user_by_id")
    {:ok, Repo.get(User, args.id)}
  end

  def get_all_users(_, args, _) do
    ActivityMonitor.update_resolver_activity("get_all_users")

    Absinthe.Relay.Connection.from_query(
      User,
      &Repo.all/1,
      args
    )
  end

  def create_user(_parent, args, _res) do
    ActivityMonitor.update_resolver_activity("create_user")

    {:ok, user} =
      %User{}
      |> User.changeset(args)
      |> Repo.insert()

    {:ok, pref} =
      args.preferences
      |> Map.put(:user_id, user.id)
      |> Resolvers.Preferences.create_preferences()

    res = Map.put(user, :preferences, pref)

    {:ok, res}
  end

  def update_user(_, args, _) do
    ActivityMonitor.update_resolver_activity("update_user")

    Repo.get(User, args.id)
    |> User.changeset(args)
    |> Repo.update()
  end
end
