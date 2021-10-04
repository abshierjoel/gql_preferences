defmodule ActivityMonitor do
  @activity_server GenServer.whereis(ActivityServer)
  def update_resolver_activity(key), do: @activity_server |> GenServer.cast({:update, key})
  def fetch_resolver_activity(key), do: @activity_server |> GenServer.call({:get, key})
end
