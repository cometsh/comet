
defmodule Sh.Comet.V0.Actor.Profile.ViewerState do
  @moduledoc """
  Metadata about the requesting account's relationship with the user. TODO: determine if we create our own graph or inherit bsky's.
  """

  @derive Jason.Encoder
  defstruct [
    
  ]

  @type t() :: %__MODULE__{
    
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Actor.Profile.ViewFull do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    avatar: nil,
    banner: nil,
    createdAt: nil,
    description: nil,
    descriptionFacets: nil,
    did: nil,
    displayName: nil,
    featuredItems: [],
    followersCount: 0,
    followsCount: 0,
    handle: nil,
    indexedAt: nil,
    playlistsCount: 0,
    tracksCount: 0,
    viewer: nil
  ]

  @type t() :: %__MODULE__{
    avatar: String.t(),
    banner: String.t(),
    createdAt: DateTime.t(),
    description: String.t(),
    descriptionFacets: Sh.Comet.V0.Richtext.Facet.Main.t(),
    did: String.t(),
    displayName: String.t(),
    featuredItems: list(String.t()),
    followersCount: integer,
    followsCount: integer,
    handle: String.t(),
    indexedAt: DateTime.t(),
    playlistsCount: integer,
    tracksCount: integer,
    viewer: Sh.Comet.V0.Actor.Profile.ViewerState.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Actor.Profile.View do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    avatar: nil,
    createdAt: nil,
    did: nil,
    displayName: nil,
    handle: nil,
    indexedAt: nil,
    viewer: nil
  ]

  @type t() :: %__MODULE__{
    avatar: String.t(),
    createdAt: DateTime.t(),
    did: String.t(),
    displayName: String.t(),
    handle: String.t(),
    indexedAt: DateTime.t(),
    viewer: Sh.Comet.V0.Actor.Profile.ViewerState.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

