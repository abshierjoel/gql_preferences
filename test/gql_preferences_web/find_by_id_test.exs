defmodule UserPreferencesTest.FindUserTest do
  use ExUnit.Case, async: true
  alias UserPreferences.{Repo, User, Preferences}
  alias UserPreferencesWeb.{Schema}
  import ExMock

  @user """
  query findById($id: ID){
    user(id: $id){
      name
      email
      id
      preferences{
        likesEmails
        likesPhoneCalls
      }
    }
  }
  """

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "@findById" do
    test "returns a user" do
      pref_mock = %{
        likes_emails: true,
        likes_phone_calls: false
      }

      user_mock = %{
        id: "55",
        name: "TestGuy",
        email: "mytestman@notatesturl.org"
      }

      with_mock Repo,
        get: fn User, _ -> user_mock end,
        get_by: fn Preferences, _ -> pref_mock end do
        assert {:ok, res} = Absinthe.run(@user, Schema, variables: %{"id" => 55})

        assert Map.equal?(res, %{
                 data: %{
                   "user" => %{
                     "id" => "55",
                     "name" => "TestGuy",
                     "email" => "mytestman@notatesturl.org",
                     "preferences" => %{
                       "likesEmails" => true,
                       "likesPhoneCalls" => false
                     }
                   }
                 }
               })
      end
    end

    test "returns nil if no user is found" do
      user_id = 1_234_456_789

      assert {:ok, %{data: %{"user" => nil}}} =
               Absinthe.run(@user, Schema, variables: %{"id" => user_id})
    end
  end
end
