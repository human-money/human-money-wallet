defmodule MasonMoneyWallet.UserController do
  use MasonMoneyWallet.Web, :controller

  def show(conn, _params) do
    conn = fetch_session(conn)
    IO.puts "#{inspect _params}"
    user = Repo.get_by(MasonMoneyWallet.User, username: _params["user_id"])

    render conn, "show.json", data: user
  end
end
