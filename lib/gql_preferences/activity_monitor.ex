defmodule ActivityMonitor do
  def update_resolver_activity(key), do: context() |> GenServer.cast({:update, key})
  def fetch_resolver_activity(key), do: context() |> GenServer.call({:get, key})

  defp context(), do: GenServer.whereis(ActivityServer)
end
