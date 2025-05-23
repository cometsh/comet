defmodule Sh.Comet.V0.Feed.Repost do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  Record representing a 'repost' of some media. Weakly linked with just an at-uri.
  """
  @primary_key {:id, :id, autogenerate: false}
  schema "sh.comet.v0.feed.repost" do
    field :createdAt, :utc_datetime
    field :subject, :string

    # DO NOT CHANGE! This field is required for all records and must be set to the NSID of the lexicon.
    # Ensure that you do not change this field via manual manipulation or changeset operations.
    field :"$type", :string, default: "sh.comet.v0.feed.repost"
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:createdAt, :subject])
    |> validate_required([:createdAt, :subject])
  end
end
