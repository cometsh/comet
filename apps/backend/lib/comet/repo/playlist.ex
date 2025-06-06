defmodule Comet.Repo.Playlist do
  @moduledoc """
  Sch ema containing information about a Comet playlist.
  """
  use Comet.Schema
  import Ecto.Changeset

  schema "playlists" do
    field :rkey, :string
    field :title, :string
    field :image, :string
    field :description, :string
    # TODO: see how this looks with/without primary id
    embeds_one :description_facets, Repo.Embed.Facet, on_replace: :update
    field :type, :string
    field :tags, {:array, :string}
    embeds_one :link, Repo.Embed.Link, on_replace: :update
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did
    has_many :tracks, Repo.Playlist

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rkey, :did, :title, :image, :description, :type, :tags, :created_at])
    |> cast_embed(:description_facets)
    |> cast_embed(:link)
    |> validate_required([:rkey, :did, :title, :type, :created_at])
  end
end
