defmodule Wallet.Services.DestinationAssigner do
  alias Wallet.Repo
  alias Wallet.User
  alias Ecto.Changeset
  alias Wallet.BitcoinAddress

  def set_destination(changeset, destination) do
    cond do
      user = username?(destination) ->
        assign_user(changeset, user)
      bitcoin_address = bitcoin_address?(destination) ->
        assign_bitcoin_address(changeset, bitcoin_address)
    end
  end

  def username?(string) do
    Repo.get_by(User, username: string)
  end

  def bitcoin_address?(string) do
    if BitcoinAddress.is?(string) do
      BitcoinAddress.find_or_create_by(%{address: string})
    end
  end

  def assign_user(changeset, user) do
    Changeset.put_change(
      changeset,
      :destination_user_id,
      user.id
    )
  end

  def assign_bitcoin_address(changeset, bitcoin_address) do
    Changeset.put_change(
      changeset,
      :destination_bitcoin_address_id,
      bitcoin_address.id
    )
  end
end
