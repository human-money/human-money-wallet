defmodule MasonMoneyWallet.ProfileController do
  use MasonMoneyWallet.Web, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end

  def update(conn, _params) do
    redirect conn, to: "/transactions"
  end
end
