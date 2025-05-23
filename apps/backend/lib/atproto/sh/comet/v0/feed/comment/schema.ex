defmodule Sh.Comet.V0.Feed.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A comment on a piece of Comet media.
  """
  @primary_key {:id, :id, autogenerate: false}
  schema "sh.comet.v0.feed.comment" do
    field :createdAt, :utc_datetime
    field :facets, {:array, :map}
    field :langs, {:array, :string}
    field :reply, :string
    field :subject, :string
    field :text, :string

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.feed.comment"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:createdAt, :facets, :langs, :reply, :subject, :text])
    |> validate_required([:createdAt, :subject, :text])
    |> validate_length(:langs, max: 3)
  end
end
