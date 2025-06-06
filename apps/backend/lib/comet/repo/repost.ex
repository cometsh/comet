defmodule Comet.Repo.Repost do
  @moduledoc """
  Schema containing information about a Comet repost.
  """
  use Comet.Schema
  import Ecto.Changeset

  schema "reposts" do
    field :rkey, :string
    field :subject_id, :binary_id
    field :subject_type, Ecto.Enum, values: [:track, :playlist]
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end

  def new(params \\ %{}), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rkey, :did, :subject_id, :subject_type, :created_at])
    |> validate_required([:rkey, :did, :subject_id, :subject_type, :created_at])
  end
end
