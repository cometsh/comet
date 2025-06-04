defmodule Comet.Repo.Playlist do
  @moduledoc """
  Schema containing information about a Comet playlist.
  """
  use Comet.Schema

  schema "playlists" do
    field :rkey, :string
    field :title, :string
    field :image, :string
    field :description, :string
    embeds_one :description_facets, Repo.Embed.Facet, on_replace: :update
    field :type, :string
    field :tags, {:array, :string}
    embeds_one :link, Repo.Embed.Link, on_replace: :update
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did
    has_many :tracks, Repo.Playlist

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end
end
