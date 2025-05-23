defmodule Sh.Comet.V0.Actor.GetProfiles do
  
  @doc """
  Get the profile views of multiple actors.
  """
  @spec main(%{
    actors: list(String.t())
  }, Atproto.xrpc_opts()) :: {:ok, %{profiles: list(Sh.Comet.V0.Actor.Profile.View.t())}} | {:error, any}
  def main(params \\ %{}, opts \\ []) do
    params
    |> Map.take([:actors])
    |> Atproto.ensure_required([:actors])
    |> Atproto.query("sh.comet.v0.actor.getProfiles", opts)
  end
end
