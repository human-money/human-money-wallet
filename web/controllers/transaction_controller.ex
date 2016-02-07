defmodule MasonMoneyWallet.TransactionController do
  use MasonMoneyWallet.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    IO.puts "hi"
  end
end
