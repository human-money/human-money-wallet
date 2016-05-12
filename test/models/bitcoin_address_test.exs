defmodule Wallet.BitcoinAddressTest do
  use Wallet.ModelCase

  alias Wallet.BitcoinAddress

  @valid_attrs %{address: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BitcoinAddress.changeset(%BitcoinAddress{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BitcoinAddress.changeset(%BitcoinAddress{}, @invalid_attrs)
    refute changeset.valid?
  end
end
