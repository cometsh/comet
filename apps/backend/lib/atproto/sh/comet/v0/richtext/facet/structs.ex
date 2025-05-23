
defmodule Sh.Comet.V0.Richtext.Facet.Timestamp do
  @moduledoc """
  Facet feature for a timestamp in a track. The text usually is in the format of 'hh:mm:ss' with the hour section being omitted if unnecessary.
  """

  @derive Jason.Encoder
  defstruct [
    timestamp: 0
  ]

  @type t() :: %__MODULE__{
    timestamp: integer
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Richtext.Facet.Tag do
  @moduledoc """
  Facet feature for a hashtag. The text usually includes a '#' prefix, but the facet reference should not (except in the case of 'double hash tags').
  """

  @derive Jason.Encoder
  defstruct [
    tag: nil
  ]

  @type t() :: %__MODULE__{
    tag: String.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Richtext.Facet.Mention do
  @moduledoc """
  Facet feature for mention of another account. The text is usually a handle, including a '@' prefix, but the facet reference is a DID.
  """

  @derive Jason.Encoder
  defstruct [
    did: nil
  ]

  @type t() :: %__MODULE__{
    did: String.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Richtext.Facet.Main do
  @moduledoc """
  Annotation of a sub-string within rich text.
  """

  @derive Jason.Encoder
  defstruct [
    features: [],
    index: nil
  ]

  @type t() :: %__MODULE__{
    features: list(any),
    index: Sh.Comet.V0.Richtext.Facet.ByteSlice.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Richtext.Facet.Link do
  @moduledoc """
  Facet feature for a URL. The text URL may have been simplified or truncated, but the facet reference should be a complete URL.
  """

  @derive Jason.Encoder
  defstruct [
    uri: nil
  ]

  @type t() :: %__MODULE__{
    uri: String.t()
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

defmodule Sh.Comet.V0.Richtext.Facet.ByteSlice do
  @moduledoc """
  Specifies the sub-string range a facet feature applies to. Start index is inclusive, end index is exclusive. Indices are zero-indexed, counting bytes of the UTF-8 encoded text. NOTE: some languages, like Javascript, use UTF-16 or Unicode codepoints for string slice indexing; in these languages, convert to byte arrays before working with facets.
  """

  @derive Jason.Encoder
  defstruct [
    byteEnd: 0,
    byteStart: 0
  ]

  @type t() :: %__MODULE__{
    byteEnd: integer,
    byteStart: integer
  }

  @spec new() :: t()
  def new(), do: %__MODULE__{}

  @spec from(binary() | map()) :: t()
  def from(json), do: Atproto.decode_to_struct(__MODULE__, json)
end

