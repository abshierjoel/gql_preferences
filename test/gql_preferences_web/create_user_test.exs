defmodule UserPreferencesTest.CreateUserTest do
  use ExUnit.Case, async: true
  alias UserPreferencesWeb.Schema

  """

  @create_user """
  mutation createUser(
    $name: String,
    $email: String,
    $likesEmails: Boolean,
    $likesPhoneCalls: Boolean
  ) {
    createUser(
      name: $name,
      email: $email,
      preferences: {
        likesEmails: $likesEmails,
        likesPhoneCalls: $likesPhoneCalls
        }
    ) {
      id
      name
      email
      preferences {
        likesEmails
        likesPhoneCalls
      }
    }
  }
  """

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(UserPreferences.Repo)
  end

  describe "@createUser" do
  end
end
