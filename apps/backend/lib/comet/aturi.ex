defmodule Comet.AtURI do
  use TypedStruct

  @did "did:(?:plc|web):[a-zA-Z0-9._:%-]*[a-zA-Z0-9._-]"
  @handle "(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
  @nsid "[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+(\.[a-zA-Z]([a-zA-Z0-9]{0,62})?)"

  @authority "(?<authority>(?:#{@did})|(?:#{@handle}))"
  @collection "(?<collection>#{@nsid})"
  @rkey "(?<rkey>[a-zA-Z0-9.-_:~]{1,512})"

  @re ~r"^at://#{@authority}(?:/#{@collection}(?:/#{@rkey})?)?$"

  typedstruct do
    field :authority, String.t(), enforce: true
    field :collection, String.t() | nil
    field :rkey, String.t() | nil
  end

  @spec new(String.t()) :: {:ok, t()} | :error
  def new(string) when is_binary(string) do
    case Regex.named_captures(@re, string) do
      %{} = captures -> {:ok, from_named_captures(captures)}
      nil -> :error
    end
  end

  @spec new!(String.t()) :: t()
  def new!(string) when is_binary(string) do
    case new(string) do
      {:ok, uri} -> uri
      :error -> raise ArgumentError, message: "Malformed at:// URI"
    end
  end

  @spec match?(String.t()) :: boolean()
  def match?(string), do: Regex.match?(@re, string)

  @spec to_string(t()) :: String.t()
  def to_string(%__MODULE__{} = uri) do
    "at://#{uri.authority}/#{uri.collection}/#{uri.rkey}"
    |> String.trim_trailing("/")
  end

  defp from_named_captures(%{"authority" => authority, "collection" => "", "rkey" => ""}),
    do: %__MODULE__{authority: authority}

  defp from_named_captures(%{"authority" => authority, "collection" => collection, "rkey" => ""}),
    do: %__MODULE__{authority: authority, collection: collection}

  defp from_named_captures(%{
         "authority" => authority,
         "collection" => collection,
         "rkey" => rkey
       }),
       do: %__MODULE__{authority: authority, collection: collection, rkey: rkey}
end

defimpl String.Chars, for: Comet.AtURI do
  def to_string(%Comet.AtURI{} = uri), do: Comet.AtURI.to_string(uri)
end
