defmodule UserPreferencesWeb.Schema do
  use Absinthe.Schema
  alias UserPreferences.{User, Preference, Repo}

  query do
    field :user, list_of(:user) do
      resolve fn _, _, _ ->
        {:ok, Repo.all(User)}
      end
    end

    field :preference, list_of(:preference) do
      resolve fn _, _, _ ->
        {:ok, Repo.all(Preference)}
      end
    end
  end

  mutation

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  object :preference do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end
end
