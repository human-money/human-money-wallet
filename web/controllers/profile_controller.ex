defmodule Wallet.ProfileController do
  use Wallet.Web, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end

  def update(conn, _params) do
    current_user_id = get_session(conn, :current_user_id)
    current_user = Wallet.Repo.get!(Wallet.User, current_user_id)
    changeset = Wallet.User.changeset(current_user, _params)
    Wallet.Repo.update(changeset)
    redirect conn, to: "/transactions"
  end
end

