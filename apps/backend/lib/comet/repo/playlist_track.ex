defmodule Comet.Repo.PlaylistTrack do
  @moduledoc """
  Schema containing information about a track in a Comet playlist.
  """
  use Comet.Schema
  import Ecto.Changeset

  schema "playlist_tracks" do
    field :rkey, :string
    field :position, :integer
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did
    belongs_to :track, Repo.Track
    belongs_to :playlist, Repo.Playlist

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rkey, :did, :position, :created_at, :track_id, :playlist_id])
    |> validate_required([:rkey, :did, :position, :created_at, :track_id, :playlist_id])
  end
end
