defmodule Wallet.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :from_bitcoin_address_id, :integer
      add :from_mason_money_address_id, :integer
      add :from_user_id, :integer
      add :to_bitcoin_address_id, :integer
      add :to_mason_money_address_id, :integer
      add :to_giftcard_id, :integer
      add :to_twitter_id, :integer
      add :to_user_id, :integer
      add :amount, :integer

      timestamps
    end

  end
end
