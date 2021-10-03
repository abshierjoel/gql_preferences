defmodule UserPreferences.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field :likes_emails, :boolean, default: false
    field :likes_phone_calls, :boolean, default: false
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, [:likes_emails, :likes_phone_calls])
    |> validate_required([:likes_emails, :likes_phone_calls])
  end
end
