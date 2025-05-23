defmodule Atproto.TID do
  @moduledoc """
  A module for encoding and decoding TIDs.

  [TID](https://atproto.com/specs/tid) stands for "Timestamp Identifier". It is a 13-character string calculated from 53 bits representing a unix timestamp, in microsecond precision, plus 10 bits for an arbitrary "clock identifier", to help with uniqueness in distributed systems.

  The string is encoded as "base32-sortable", meaning that the characters for the base 32 encoding are set up in such a way that string comparisons yield the same result as integer comparisons, i.e. if the integer representation of the timestamp that creates TID "A" is greater than the integer representation of the timestamp that creates TID "B", then "A" > "B" is also true, and vice versa.
  """

  import Bitwise

  @tid_char_set ~c(234567abcdefghijklmnopqrstuvwxyz)
  @tid_char_set_length 32

  defstruct [
    :timestamp,
    :clock_id,
    :string
  ]

  @typedoc """
  TIDs are composed of two parts: a timestamp and a clock identifier. They also have a human-readable string representation as a "base32-sortable" encoded string.
  """
  @type t() :: %__MODULE__{
    timestamp: integer(),
    clock_id: integer(),
    string: binary()
  }

  @doc """
  Generates a random 10-bit clock identifier.
  """
  @spec random_clock_id() :: integer()
  def random_clock_id(), do: :rand.uniform(1024) - 1

  @doc """
  Generates a new TID for the current time.

  This is equivalent to calling `encode(nil)`.
  """
  @spec new() :: t()
  def new(), do: encode(nil)

  @doc """
  Encodes an integer or DateTime struct into a 13-character string that is "base32-sortable" encoded.

  If `timestamp` is nil, or not provided, the current time will be used as represented by `DateTime.utc_now()`.

  If `clock_id` is nil, or not provided, a random 10-bit integer will be used.

  If `timestamp` is an integer value, it *MUST* be a unix timestamp measured in microseconds. This function does not validate integer values.
  """
  @spec encode(nil | integer() | DateTime.t(), nil | integer()) :: t()
  def encode(timestamp \\ nil, clock_id \\ nil)

  def encode(nil, clock_id), do: encode(DateTime.utc_now(), clock_id)

  def encode(timestamp, nil), do: encode(timestamp, random_clock_id())

  def encode(%DateTime{} = datetime, clock_id) do
    datetime
    |> DateTime.to_unix(:microsecond)
    |> encode(clock_id)
  end

  def encode(timestamp, clock_id) when is_integer(timestamp) and is_integer(clock_id) do
    # Ensure we only use the lower 10 bit of clock_id
    clock_id = clock_id &&& 1023
    str =
      timestamp
      |> bsr(10)
      |> bsl(10)
      |> bxor(clock_id)
      |> do_encode("")
    %__MODULE__{timestamp: timestamp, clock_id: clock_id, string: str}
  end

  defp do_encode(0, acc), do: acc

  defp do_encode(number, acc) do
    c = rem(number, @tid_char_set_length)
    number = div(number, @tid_char_set_length)
    do_encode(number, <<Enum.at(@tid_char_set, c)>> <> acc)
  end

  @doc """
  Decodes a binary string into a TID struct.
  """
  @spec decode(binary()) :: t()
  def decode(tid) do
    num = do_decode(tid, 0)
    %__MODULE__{timestamp: bsr(num, 10), clock_id: num &&& 1023, string: tid}
  end

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<char::utf8, rest::binary>>, acc) do
    idx = Enum.find_index(@tid_char_set, fn x -> x == char end)
    do_decode(rest, (acc * @tid_char_set_length) + idx)
  end
end

defimpl String.Chars, for: Atproto.TID do
  def to_string(tid), do: tid.string
end
