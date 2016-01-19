defmodule MasonMoneyWallet.CurrentUserController do
  use MasonMoneyWallet.Web, :controller

  def show(conn, _params) do
    conn = fetch_session(conn)
    user = Repo.get_by(MasonMoneyWallet.User, id: get_session(conn, :current_user_id))

    render conn, "show.json", data: user
  end
end
