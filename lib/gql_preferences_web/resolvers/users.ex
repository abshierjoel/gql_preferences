defmodule UserPreferencesWeb.Resolvers.Users do
  alias UserPreferences.{Repo, User, Preferences}

  def get_user_by_id(_parent, args, _res), do: {:ok, Repo.get(User, args.id)}

  def get_all_users(_, args, _),
    do:
      Absinthe.Relay.Connection.from_query(
        User,
        &Repo.all/1,
        args
      )

  def create_user(_parent, args, _res) do
    {:ok, user} =
      %User{}
      |> User.changeset(args)
      |> Repo.insert()

    pref_args = Map.put(args.preferences, :user_id, user.id)

    {:ok, pref} =
      %Preferences{}
      |> Preferences.changeset(pref_args)
      |> Repo.insert()

    res = Map.put(user, :preferences, pref)

    {:ok, res}
  end

  def update_user(_, args, _) do
    Repo.get(User, args.id)
    |> User.changeset(args)
    |> Repo.update()
  end
end
