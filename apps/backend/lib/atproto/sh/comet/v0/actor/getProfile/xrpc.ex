defmodule Sh.Comet.V0.Actor.GetProfile do
  
  @doc """
  Get the profile view of an actor.
  """
  @spec main(%{
    actor: String.t()
  }, Atproto.xrpc_opts()) :: {:ok, Sh.Comet.V0.Actor.Profile.View.t()} | {:error, any}
  def main(params \\ %{}, opts \\ []) do
    params
    |> Map.take([:actor])
    |> Atproto.ensure_required([:actor])
    |> Atproto.query("sh.comet.v0.actor.getProfile", opts)
  end
end
