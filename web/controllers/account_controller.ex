defmodule MasonMoneyWallet.AccountController do
  use MasonMoneyWallet.Web, :controller

  def show(conn, _params) do
    render conn, "index.html"
  end
end
