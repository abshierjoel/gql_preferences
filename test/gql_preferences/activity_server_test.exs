defmodule UserPreferences.ActivityServer.Test do
  use ExUnit.Case
  alias ActivityServer

  describe "ActivityServer" do
    test "returns count for existing resolver" do
      key = "get_all_users"
      assert {:ok, 0} = GenServer.whereis(ActivityServer) |> GenServer.call({:get, key})
    end

    test "returns error for non-existing resolver" do
      key = "burn_all_ships"
      {:error, msg} = GenServer.whereis(ActivityServer) |> GenServer.call({:get, key})
      assert msg == "Requested key: #{key} is invalid"
    end
  end
end
