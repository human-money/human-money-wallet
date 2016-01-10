defmodule MasonMoneyWallet.ProfileController do
  use MasonMoneyWallet.Web, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end

  def update(conn, _params) do
    current_user_id = get_session(conn, :current_user_id)
    current_user = MasonMoneyWallet.Repo.get!(MasonMoneyWallet.User, current_user_id)
    changeset = MasonMoneyWallet.User.changeset(current_user, _params)
    MasonMoneyWallet.Repo.update(changeset)
    redirect conn, to: "/transactions"
  end
end

