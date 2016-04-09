defmodule Wallet.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :facebook_id, :string
      add :private_key, :string
      add :public_key, :string

      timestamps
    end

  end
end
