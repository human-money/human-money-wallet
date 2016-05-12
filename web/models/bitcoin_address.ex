defmodule Wallet.BitcoinAddress do
  use Wallet.Web, :model
  alias Wallet.Repo
  alias Wallet.BitcoinAddress

  schema "bitcoin_addresses" do
    field :address, :string

    timestamps
  end

  @required_fields ~w(address)
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

  def is?(string) do
    String.starts_with?(string, "1")
  end

  def find_or_create_by(%{:address => address}) do
    if bitcoin_address = Repo.get_by(BitcoinAddress, address: address) do
      bitcoin_address
    else
      {:ok, bitcoin_address} = %Wallet.BitcoinAddress{address: address} |> Repo.insert
      bitcoin_address
    end
  end
end
