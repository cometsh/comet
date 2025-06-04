defmodule Comet.Repo.Profile do
  @moduledoc """
  Schema containing information about a Comet profile.
  """
  use Comet.Schema

  schema "profiles" do
    field :rkey, :string, default: "self"
    field :display_name, :string
    field :description, :string
    embeds_one :description_facets, Repo.Embed.Facet, on_replace: :update
    field :avatar, :string
    field :banner, :string
    field :featured_items, {:array, :string}
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end
end
