defmodule UserPreferences.Repo.Migrations.RequireUserId do
  use Ecto.Migration

  def change do
    alter table(:preferences) do
      modify :user_id, :integer, null: false
    end
  end
end
