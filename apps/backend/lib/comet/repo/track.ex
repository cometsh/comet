defmodule Comet.Repo.Track do
  @moduledoc """
  Schema containing information about a Comet track.
  """
  use Comet.Schema
  import Ecto.Changeset

  schema "tracks" do
    field :rkey, :string
    field :title, :string
    field :audio, :string
    field :image, :string
    field :description, :string
    embeds_one :description_facets, Repo.Embed.Facet, on_replace: :update
    field :explicit, :boolean
    field :tags, {:array, :string}
    embeds_one :link, Repo.Embed.Link, on_replace: :update
    field :created_at, :utc_datetime
    field :released_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :rkey,
      :did,
      :title,
      :audio,
      :image,
      :description,
      :explicit,
      :tags,
      :created_at,
      :released_at
    ])
    |> cast_embed(:description_facets)
    |> cast_embed(:link)
    |> validate_required([:rkey, :did, :audio, :title, :created_at])
  end
end
