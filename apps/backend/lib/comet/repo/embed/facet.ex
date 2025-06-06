defmodule Comet.Repo.Embed.Facet do
  use Comet.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one :index, ByteSlice do
      field :byte_start, :integer
      field :byte_end, :integer
    end

    # Sadly Ecto doesn't support union types/embeds so this has to be generic, without doing weirdness in the database at least
    field :features, {:array, :map}
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:features])
    |> cast_embed(:index, required: true)
    |> validate_required([:features])
  end
end
