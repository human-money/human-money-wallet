defmodule Wallet.TransactionView do
  use Wallet.Web, :view
  @attributes ~W(id)

  def render("index.json", %{data: data}) do
    %{transactions: render_many(data, Wallet.TransactionView, "transaction.json")}
  end

  def render("show.json", %{data: data}) do
    %{transaction: render_one(data, Wallet.TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
    |> Map.take([
      :id,
      :source_bitcoin_address_id,
      :source_mason_money_address_id,
      :source_user_id,
      :destination_bitcoin_address_id,
      :destination_mason_money_address_id,
      :destination_giftcard_id,
      :destination_twitter_id,
      :destination_user_id,
      :amount,
      :inserted_at
    ])
  end
end
