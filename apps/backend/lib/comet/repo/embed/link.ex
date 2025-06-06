defmodule Comet.Repo.Embed.Link do
  use Comet.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :type, :string
    field :value, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :value])
    |> validate_required([:type, :value])
  end
end
