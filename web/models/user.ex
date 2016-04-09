defmodule Wallet.User do
  use Wallet.Web, :model

  schema "users" do
    field :username, :string
    field :facebook_id, :string
    field :private_key, :string
    field :public_key, :string

    timestamps
  end

  @required_fields ~w(username facebook_id private_key)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
