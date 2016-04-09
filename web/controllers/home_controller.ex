defmodule Wallet.HomeController do
  use Wallet.Web, :controller

  def index(conn, _params) do
    current_user_id = get_session(conn, :current_user_id)
    if current_user_id do
      render conn, "index.html"
    else
      redirect conn, to: "/auth/facebook"
    end
  end
end

