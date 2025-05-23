
defmodule Sh.Comet.V0.Feed.Track.View do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    audio: nil,
    author: nil,
    cid: nil,
    commentCount: 0,
    image: nil,
    indexedAt: nil,
    likeCount: 0,
    playCount: 0,
    record: nil,
    repostCount: 0,
    uri: nil,
    viewer: nil
  ]

  @type t() :: %__MODULE__{
    audio: String.t(),
    author: Sh.Comet.V0.Actor.Profile.ViewFull.t(),
    cid: String.t(),
    commentCount: integer,
    image: String.t(),
    indexedAt: DateTime.t(),
    likeCount: integer,
    playCount: integer,
    record: Sh.Comet.V0.Feed.Track.Main.t(),
    repostCount: integer,
    uri: String.t(),
    viewer: Sh.Comet.V0.Feed.Defs.ViewerState.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

