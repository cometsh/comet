defmodule Comet.Repo.Profile do
  @moduledoc """
  Schema containing information about a Comet profile.
  """
  use Comet.Schema
  import Ecto.Changeset

  # TODO: should probably keep track of CID so as to not do unnecessary writes
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

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :rkey,
      :did,
      :display_name,
      :description,
      :avatar,
      :banner,
      :featured_items,
      :created_at
    ])
    |> cast_embed(:description_facets)
    |> validate_required([:rkey, :did])
  end
end
