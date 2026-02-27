defmodule Comet.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :did, :string, primary_key: true
      add :display_name, :string
      add :description, :string
      add :description_facets, :map
      add :avatar, :string
      add :banner, :string
      add :featured_items, {:array, :string}, default: []

      timestamps(type: :utc_datetime)
    end
  end
end
