defmodule UserPreferences.Preferences do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field :likes_emails, :boolean, default: false
    field :likes_phone_calls, :boolean, default: false
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(preferences, attrs) do
    preferences
    |> cast(attrs, [:likes_emails, :likes_phone_calls, :user_id])
    |> validate_required([:likes_emails, :likes_phone_calls, :user_id])
  end
end
