defmodule Wallet.Services.Bitcoin do
  alias Wallet.Repo
  alias Wallet.BitcoinAddress

  def deliver(transaction) do
    if transaction.destination_bitcoin_address_id do
      value = value_of(transaction)
      IO.puts "Sending #{value}"
      bitcoin_address = Repo.get(BitcoinAddress, transaction.destination_bitcoin_address_id)
      response = HTTPotion.get("https://block.io/api/v2/withdraw/?api_key=#{block_io_api_key}&amounts=#{value}&to_addresses=#{bitcoin_address.address}&pin=#{block_io_pin}")
      IO.puts response.body
    end
  end

  def value_of(transaction) do
    Float.to_string((transaction.amount / 10000) / bitcoin_conversion_rate, [decimals: 8])
  end

  def bitcoin_conversion_rate do
    Application.get_env(:wallet, :bitcoin_conversion_rate)
  end

  def block_io_api_key do
    Application.get_env(:wallet, :block_io_api_key)
  end

  def block_io_pin do
    Application.get_env(:wallet, :block_io_pin)
  end
end
