defmodule UserPreferencesWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  use Absinthe.Relay.Schema.Notation, :modern

  alias UserPreferencesWeb.Resolvers

  connection(node_type: :user)

  node interface do
    resolve_type(fn
      %UserPreferences.User{}, _ ->
        :user

      _, _ ->
        nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :user, id: local_id}, _ ->
          {:ok, UserPreferences.Repo.get(UserPreferences.User, local_id)}

        _, _ ->
          {:error, "Unknown node"} |> IO.inspect()
      end)
    end

    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Users.get_user_by_id/3)
    end

    connection field :users, node_type: :user do
      arg(:before, :integer)
      arg(:after, :integer)
      arg(:first, :integer)
      arg(:name, :string)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      resolve(&Resolvers.Users.get_all_users/3)
    end
  end

  mutation do
    field :create_user, :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:preferences, :preferences_input)

      resolve(&Resolvers.Users.create_user/3)
    end

    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      resolve(&Resolvers.Users.update_user/3)
    end

    field :update_user_preferences, :preferences do
      arg(:user_id, non_null(:id))
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      resolve(&Resolvers.Preferences.update_preferences_by_id/3)
    end
  end

  node object(:user) do
    field :id, :id
    field :name, :string
    field :email, :string

    field :preferences, :preferences do
      arg(:user_id, :id)
      resolve(&Resolvers.Preferences.get_preferences/3)
    end
  end

  node object(:preferences) do
    field :user_id, :id
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end

  input_object :preferences_input do
    field :likes_emails, non_null(:boolean)
    field :likes_phone_calls, non_null(:boolean)
  end
end
