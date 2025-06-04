defmodule Comet.Repo.Migrations.Init do
  use Ecto.Migration

  defmacrop did_rkey do
    quote do
      add :did, references(:identity, column: :did, type: :string), null: false
      add :rkey, :string, null: false
    end
  end

  def change do
    create table(:identity, primary_key: false) do
      add :did, :string, primary_key: true, null: false
      add :handle, :string
      add :active, :boolean, null: false
      add :status, :string
      # TODO: cache of did record?
      timestamps(inserted_at: :indexed_at, updated_at: false)
    end

    create table(:profiles) do
      did_rkey()
      add :display_name, :string
      add :description, :string
      # TODO: as a table?
      add :description_facets, :map
      add :avatar, :string
      add :banner, :string
      # TODO: as a table?
      add :featured_items, {:array, :string}
      add :created_at, :utc_datetime
      timestamps(inserted_at: :indexed_at, updated_at: false)
    end

    create unique_index(:profiles, [:did, :rkey])

    create table(:tracks) do
      did_rkey()
      add :title, :string, null: false
      add :audio, :string, null: false
      add :image, :string
      add :description, :string
      add :description_facets, :map
      add :explicit, :boolean
      # TODO: table for easier linking?
      add :tags, {:array, :string}
      add :link, :map
      add :created_at, :utc_datetime, null: false
      add :released_at, :utc_datetime
      timestamps(inserted_at: :indexed_at, updated_at: false)
    end

    create index(:tracks, [:did, :rkey])

    create table(:playlists) do
      did_rkey()
      add :title, :string, null: false
      add :image, :string
      add :description, :string
      add :description_facets, :map
      add :type, :string, null: false
      add :tags, {:array, :string}
      add :link, :map
      add :created_at, :utc_datetime, null: false
      timestamps(inserted_at: :indexed_at, updated_at: false)
    end

    # TODO: probably still can do unique index on this
    create index(:playlists, [:did, :rkey])

    create table(:playlist_tracks) do
      did_rkey()

      add :track_id, references(:tracks), null: false
      add :playlist_id, references(:playlists), null: false

      add :position, :integer, null: true
      add :created_at, :utc_datetime, null: false
      timestamps(inserted_at: :indexed_at, updated_at: false)
    end

    create index(:playlist_tracks, [:did, :rkey])
    # create unique_index()

    create table(:likes) do
      did_rkey()
      # add :subject_did, :string, null: false
      add :subject_id, :binary_id, null: false
      add :subject_type, :string, null: false
      add :created_at, :utc_datetime, null: false
    end

    create index(:likes, [:did, :rkey])
    create unique_index(:likes, [:did, :subject_id])

    create table(:reposts) do
      did_rkey()
      # add :subject_did, :string, null: false
      add :subject_id, :binary_id, null: false
      add :subject_type, :string, null: false
      add :created_at, :utc_datetime, null: false
    end

    create index(:reposts, [:did, :rkey])
    create unique_index(:reposts, [:did, :subject_id])

    create table(:plays) do
      did_rkey()
      add :subject, references(:tracks), null: false
      add :created_at, :utc_datetime, null: false
    end

    create index(:plays, [:did, :rkey])

    create table(:comments) do
      did_rkey()
      add :text, :string, null: false
      add :subject_id, :binary_id, null: false
      add :subject_type, :string, null: false
      add :reply_id, references(:comments)
      # add :reply, :string
      add :langs, {:array, :string}
      add :facets, :map
      add :created_at, :utc_datetime, null: false
    end

    create index(:comments, [:did, :rkey])
  end
end
