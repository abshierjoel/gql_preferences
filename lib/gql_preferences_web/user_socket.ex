defmodule UserPreferencesWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: UserPreferencesWeb.Schema

  def connect(_params, socket) do
    socket
    |> Absinthe.Phoenix.Socket.put_options(context: %{})
    |> then(&{:ok, &1})
  end

  def id(_socket), do: nil
end
