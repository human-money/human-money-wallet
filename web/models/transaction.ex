defmodule MasonMoneyWallet.Transaction do
  use MasonMoneyWallet.Web, :model

  schema "transactions" do
    belongs_to :from_bitcoin_address, :integer
    belongs_to :from_mason_money_address, :integer
    belongs_to :from_user, :integer
    belongs_to :to_bitcoin_address, :integer
    belongs_to :to_mason_money_address, :integer
    belongs_to :to_giftcard, :integer
    belongs_to :to_twitter, :integer
    belongs_to :to_user, :integer
    field :amount, :integer

    timestamps
  end

  @required_fields ~w(amount)
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
