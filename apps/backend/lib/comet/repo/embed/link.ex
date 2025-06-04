defmodule Comet.Repo.Embed.Link do
  use Comet.Schema

  @primary_key false
  embedded_schema do
    field :type, :string
    field :value, :string
  end
end
