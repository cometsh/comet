defmodule Sh.Comet.V0.Feed.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A Comet playlist, containing many audio tracks.
  """
  @primary_key {:id, :id, autogenerate: false}
  schema "sh.comet.v0.feed.playlist" do
    field :createdAt, :utc_datetime
    field :description, :string
    field :descriptionFacets, :map
    field :image, :map
    field :link, :map
    field :tags, {:array, :string}
    field :title, :string
    field :type, :string

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.feed.playlist"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:createdAt, :description, :descriptionFacets, :image, :link, :tags, :title, :type])
    |> validate_required([:createdAt, :title, :type])
    |> validate_length(:tags, max: 8)
  end
end
