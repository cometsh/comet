
defmodule Sh.Comet.V0.Feed.Defs.ViewerState do
  @moduledoc """
  Metadata about the requesting account's relationship with the subject content. Only has meaningful content for authed requests.
  """

  @derive Jason.Encoder
  defstruct [
    featured: false,
    like: nil,
    repost: nil
  ]

  @type t() :: %__MODULE__{
    featured: boolean,
    like: String.t(),
    repost: String.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Feed.Defs.Link do
  @moduledoc """
  Link for the track. Usually to acquire it in some way, e.g. via free download or purchase. | TODO: multiple links?
  """

  @derive Jason.Encoder
  defstruct [
    type: nil,
    value: nil
  ]

  @type t() :: %__MODULE__{
    type: String.t(),
    value: String.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

