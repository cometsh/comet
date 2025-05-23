defmodule Sh.Comet.V0.Feed.GetActorPlaylists do
  
  @doc """
  Get a list of an actor's playlists.
  """
  @spec main(%{
    actor: String.t(),
    cursor: String.t(),
    limit: integer
  }, Atproto.xrpc_opts()) :: {:ok, %{cursor: String.t(), playlists: list(Sh.Comet.V0.Feed.Playlist.View.t())}} | {:error, any}
  def main(params \\ %{}, opts \\ []) do
    params
    |> Map.take([:actor, :cursor, :limit])
    |> Atproto.ensure_required([:actor])
    |> Atproto.query("sh.comet.v0.feed.getActorPlaylists", opts)
  end
end
