defmodule Comet.Repo.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key {:did, :string, autogenerate: false}

  schema "profiles" do
    field :display_name, :string
    field :description, :string
    field :description_facets, :map
    field :avatar, :string
    field :banner, :string
    field :featured_items, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(did)a
  @optional_fields ~w(display_name description description_facets avatar banner featured_items)a

  @doc """
  Changeset for creating or updating a profile record.

  `did` is the primary key and must be provided. `avatar` and `banner` are
  CID strings referencing blob records. All other fields from the
  `sh.comet.v0.actor.profile` lexicon record definition are optional.
  """
  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile, attrs) do
    profile
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:display_name, max: 640)
    |> validate_length(:description, max: 2560)
    |> validate_length(:featured_items, max: 5)
  end
end
