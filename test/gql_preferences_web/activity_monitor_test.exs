defmodule UserPreferencesTest.ActivityMonitorTest do
  use ExUnit.Case, async: true
  alias UserPreferencesWeb.Schema

  @get_resolver_hits """
    query getResolverHits($key: String){
      resolverHits(key: $key)
    }
  """

  describe "@resolverHits" do
    test "returns the count for a resolver" do
      key = "get_all_users"

      assert {:ok, %{data: %{"resolverHits" => count}}} =
               Absinthe.run(@get_resolver_hits, Schema, variables: %{"key" => key})

      assert count === 0
    end

    test "returns" do
      key = "not_a_key"

      assert {:ok, %{data: %{"resolverHits" => count}, errors: errors}} =
               Absinthe.run(@get_resolver_hits, Schema, variables: %{"key" => key})

      assert is_nil(count) === true
      assert List.first(errors).message === "Requested key: #{key} is invalid"
    end
  end
end
