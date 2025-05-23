defmodule Sh.Comet.V0.Feed.Track do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A Comet audio track. TODO: should probably have some sort of pre-calculated waveform, or have a query to get one from a blob?
  """
  @primary_key {:id, :id, autogenerate: false}
  schema "sh.comet.v0.feed.track" do
    field :audio, :map
    field :createdAt, :utc_datetime
    field :description, :string
    field :descriptionFacets, :map
    field :image, :map
    field :link, :map
    field :tags, {:array, :string}
    field :title, :string

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.feed.track"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:audio, :createdAt, :description, :descriptionFacets, :image, :link, :tags, :title])
    |> validate_required([:audio, :createdAt, :title])
    |> validate_length(:tags, max: 8)
  end
end
