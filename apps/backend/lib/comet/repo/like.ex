defmodule Comet.Repo.Like do
  @moduledoc """
  Schema containing information about a Comet like.
  """
  use Comet.Schema

  schema "likes" do
    field :rkey, :string
    field :subject_id, :binary_id
    field :subject_type, Ecto.Enum, values: [:track, :playlist]
    field :created_at, :utc_datetime

    belongs_to :identity, Repo.Identity, foreign_key: :did, references: :did

    timestamps(inserted_at: :indexed_at, updated_at: false)
  end
end
