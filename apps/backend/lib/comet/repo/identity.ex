defmodule Comet.Repo.Identity do
  @moduledoc """
  Schema containing information about an ATProtocol identity.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:did, :string, autogenerate: false}
  @foreign_key_type :string

  schema "identity" do
    field :handle, :string
    field :active, :boolean
    field :status, :string

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:did, :handle, :active, :status])
    |> validate_required([:did, :active])
  end
end
