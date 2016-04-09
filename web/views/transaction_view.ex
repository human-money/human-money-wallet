defmodule Wallet.TransactionView do
  use Wallet.Web, :view
  @attributes ~W(id)

  def render("index.json", %{data: data}) do
    %{transactions: render_many(data, Wallet.TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
    |> Map.take([
      :id,
      :from_bitcoin_address_id,
      :from_mason_money_address_id,
      :from_user_id,
      :to_bitcoin_address_id,
      :to_mason_money_address_id,
      :to_giftcard_id,
      :to_twitter_id,
      :to_user_id,
      :amount,
      :inserted_at
    ])
  end
end
