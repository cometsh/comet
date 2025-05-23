defmodule Sh.Comet.V0.Feed.PlaylistTrack do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A link between a Comet track and a playlist.
  """
  @primary_key {:id, :id, autogenerate: false}
  schema "sh.comet.v0.feed.playlistTrack" do
    field :playlist, :string
    field :position, :integer
    field :track, :string

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.feed.playlistTrack"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:playlist, :position, :track])
    |> validate_required([:playlist, :position, :track])
    |> validate_length(:position, min: 0)
  end
end
