defmodule Comet.Profiles do
  @moduledoc """
  Context for managing local profile records.
  """

  import Ecto.Query

  alias Comet.Repo
  alias Comet.Repo.Profile

  @collection "sh.comet.v0.actor.profile"
  @rkey "self"

  @doc """
  Ensures a profile row exists in the database for the given DID.

  Checks the local database first. If no row exists, fetches the profile record
  from the user's AT Protocol repo via `com.atproto.repo.getRecord`. If the repo
  has no profile record, a stub row is inserted with no information.

  Returns `{:ok, profile}` on success or `{:error, reason}` on failure.
  """
  @spec ensure_profile(String.t(), Atex.XRPC.OAuthClient.t()) ::
          {:ok, Profile.t()} | {:error, any()}
  def ensure_profile(did, xrpc_client) do
    case Repo.one(from p in Profile, where: p.did == ^did) do
      %Profile{} = profile ->
        {:ok, profile}

      nil ->
        fetch_and_insert(did, xrpc_client)
    end
  end

  @spec fetch_and_insert(String.t(), Atex.XRPC.OAuthClient.t()) ::
          {:ok, Profile.t()} | {:error, any()}
  defp fetch_and_insert(did, xrpc_client) do
    query = %Com.Atproto.Repo.GetRecord{
      params: %{
        repo: did,
        collection: @collection,
        rkey: @rkey
      }
    }

    case Atex.XRPC.get(xrpc_client, query) do
      {:ok, %{body: %Com.Atproto.Repo.GetRecord.Output{value: record}}, _client} ->
        insert_profile(did, record)

      {:ok, %{status: 400}, _client} ->
        insert_stub(did, xrpc_client)

      {:error, %{status: 400}, _client} ->
        insert_stub(did, xrpc_client)

      {:error, reason, _client} ->
        {:error, reason}
    end
  end

  @spec insert_profile(String.t(), map()) :: {:ok, Profile.t()} | {:error, any()}
  defp insert_profile(did, record) do
    attrs =
      %{did: did}
      |> put_if_present(:display_name, record["displayName"])
      |> put_if_present(:description, record["description"])
      |> put_if_present(:description_facets, record["descriptionFacets"])
      |> put_if_present(:featured_items, record["featuredItems"])
      |> put_if_present(:avatar, get_in(record, ["avatar", "ref", "$link"]))
      |> put_if_present(:banner, get_in(record, ["banner", "ref", "$link"]))

    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  @spec insert_stub(String.t(), Atex.XRPC.OAuthClient.t()) :: {:ok, Profile.t()} | {:error, any()}
  defp insert_stub(did, xrpc_client) do
    procedure = %Com.Atproto.Repo.PutRecord{
      input: %Com.Atproto.Repo.PutRecord.Input{
        repo: did,
        collection: @collection,
        rkey: @rkey,
        record: %{"$type" => @collection}
      }
    }

    with {:ok, _response, _client} <- Atex.XRPC.post(xrpc_client, procedure) do
      %Profile{}
      |> Profile.changeset(%{did: did})
      |> Repo.insert()
    end
  end

  @spec put_if_present(map(), atom(), any()) :: map()
  defp put_if_present(map, _key, nil), do: map
  defp put_if_present(map, key, value), do: Map.put(map, key, value)
end
