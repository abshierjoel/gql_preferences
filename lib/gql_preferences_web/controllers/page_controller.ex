defmodule UserPreferencesWeb.PageController do
  use UserPreferencesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
