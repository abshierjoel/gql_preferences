defmodule UserPreferencesWeb.Resolvers.Activity do
  def get_activity(_, args, _) do
    ActivityMonitor.update_resolver_activity("get_activity")
    ActivityMonitor.fetch_resolver_activity(args.key)
  end
end
