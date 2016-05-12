defmodule Wallet.Transaction do
  use Wallet.Web, :model

  schema "transactions" do
    belongs_to :source_bitcoin_address, :integer
    belongs_to :source_mason_money_address, :integer
    belongs_to :source_user, Wallet.User
    belongs_to :destination_bitcoin_address, :integer
    belongs_to :destination_mason_money_address, :integer
    belongs_to :destination_giftcard, :integer
    belongs_to :destination_twitter, :integer
    belongs_to :destination_user, :integer
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
