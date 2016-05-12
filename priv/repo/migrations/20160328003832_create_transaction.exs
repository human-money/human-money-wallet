defmodule Wallet.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :source_bitcoin_address_id, :integer
      add :source_mason_money_address_id, :integer
      add :source_user_id, :integer
      add :destination_bitcoin_address_id, :integer
      add :destination_mason_money_address_id, :integer
      add :destination_giftcard_id, :integer
      add :destination_twitter_id, :integer
      add :destination_user_id, :integer
      add :amount, :integer

      timestamps
    end

  end
end
