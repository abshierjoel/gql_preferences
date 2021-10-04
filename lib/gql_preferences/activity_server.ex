defmodule ActivityServer do
  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: ActivityServer)
  def init(_), do: {:ok, %{}}

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
