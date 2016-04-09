defmodule Wallet.PageController do
  use Wallet.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
