defmodule Wallet.RootController do
  use Wallet.Web, :controller

  def show(conn, _params) do
    redirect conn, to: "/auth/facebook"
  end
end
