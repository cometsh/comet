defmodule Comet.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      alias Comet.Repo

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
