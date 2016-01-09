defmodule MasonMoneyWallet.TransactionController do
  use MasonMoneyWallet.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
