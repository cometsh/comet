defmodule Sh.Comet.V0.Actor.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A user's Comet profile.
  """
  @primary_key {:id, :binary_id, autogenerate: false}
  schema "sh.comet.v0.actor.profile" do
    field :avatar, :map
    field :banner, :map
    field :createdAt, :utc_datetime
    field :description, :string
    field :descriptionFacets, :map
    field :displayName, :string
    field :featuredItems, {:array, :string}

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.actor.profile"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:avatar, :banner, :createdAt, :description, :descriptionFacets, :displayName, :featuredItems])
    |> validate_length(:featuredItems, max: 5)
  end
end
