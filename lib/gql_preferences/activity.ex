defmodule Activity do
  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, %{})
  def init(_), do: {:ok, %{}}

  def handle_cast({:update, key}, state) do
    case Map.has_key?(state, key) do
      true ->
        {:noreply, Map.update(state, key, 1, fn {k, v} -> {k, v + 1} end)}

      _ ->
        {:noreply, Map.put(state, key, 1)}
    end
  end
end
