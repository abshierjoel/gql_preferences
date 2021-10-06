defmodule ActivityServer do
  use GenServer

  @resolvers [
    "get_user_by_id",
    "get_all_users",
    "create_user",
    "update_user",
    "get_preferences",
    "update_preferences_by_id"
  ]

  def start_link(_),
    do: GenServer.start_link(__MODULE__, Map.new(@resolvers, &{&1, 0}), name: ActivityServer)

  def init(args), do: {:ok, args}

  def handle_cast({:update, key}, state) do
    {:noreply, Map.update(state, key, 1, &(&1 + 1))}
  end

  def handle_call({:get, key}, _from, state) do
    if Map.has_key?(state, key) do
      {:reply, {:ok, Map.get(state, key)}, state}
    else
      {:reply, {:error, "Requested key: #{key} is invalid"}, state}
    end
  end
end
