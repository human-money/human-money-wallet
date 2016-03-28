defmodule Account do
  use Ecto.Schema

  schema "abstract table: accounts" do
    field :account_id, :integer
  end
end
