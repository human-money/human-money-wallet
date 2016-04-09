defmodule Wallet.AccountController do
  use Wallet.Web, :controller

  def show(conn, _params) do
    render conn, "index.html"
  end
end
