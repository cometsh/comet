defmodule Sh.Comet.V0.Feed.GetActorTracks do
  
  @doc """
  Get a list of an actor's tracks.
  """
  @spec main(%{
    actor: String.t(),
    cursor: String.t(),
    limit: integer
  }, Atproto.xrpc_opts()) :: {:ok, %{cursor: String.t(), tracks: list(Sh.Comet.V0.Feed.Track.View.t())}} | {:error, any}
  def main(params \\ %{}, opts \\ []) do
    params
    |> Map.take([:actor, :cursor, :limit])
    |> Atproto.ensure_required([:actor])
    |> Atproto.query("sh.comet.v0.feed.getActorTracks", opts)
  end
end
