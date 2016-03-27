defmodule MasonMoneyWallet.RootController do
  use MasonMoneyWallet.Web, :controller

  def show(conn, _params) do
    redirect conn, to: "/auth/facebook"
  end
end
