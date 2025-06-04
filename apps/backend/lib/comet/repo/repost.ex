defmodule Comet.Repo.Repost do
  @moduledoc """
  Schema containing information about a Comet repost.
  """
  use Comet.Schema

  schema "reposts" do
    field :rkey, :string
    field :subject_id, :binary_id
    field :subject_type, Ecto.Enum, values: [:track, :playlist]
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end
end
