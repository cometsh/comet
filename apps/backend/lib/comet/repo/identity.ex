defmodule Comet.Repo.Identity do
  @moduledoc """
  Schema containing information about an ATProtocol identity.
  """
  use Ecto.Schema

  @primary_key {:did, :string, autogenerate: false}
  @foreign_key_type :string

  schema "identity" do
    field :handle, :string
    field :active, :boolean
    # TODO: see if it'd be possible to set this to an enum, if ecto allows open enums
    field :status, :string

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end
end
