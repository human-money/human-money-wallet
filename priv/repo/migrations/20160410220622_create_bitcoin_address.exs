defmodule Wallet.Repo.Migrations.CreateBitcoinAddress do
  use Ecto.Migration

  def change do
    create table(:bitcoin_addresses) do
      add :address, :string

      timestamps
    end

  end
end
