defmodule Comet.Repo.Comment do
  @moduledoc """
  Schema containing information about a Comet comment.
  """
  use Comet.Schema
  import Ecto.Changeset

  schema "comments" do
    field :rkey, :string
    field :text, :string
    embeds_one :facets, Repo.Embed.Facet, on_replace: :update
    field :subject_id, :binary_id
    field :subject_type, Ecto.Enum, values: [:track, :playlist]
    field :langs, {:array, :string}
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did
    belongs_to :parent, __MODULE__, foreign_key: :reply_id
    has_many :replies, __MODULE__, foreign_key: :reply_id

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rkey, :did, :text, :facets, :subject_id, :subject_type, :langs, :created_at])
    |> validate_required([:rkey, :text])
  end
end
