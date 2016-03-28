defmodule MasonMoneyWallet.TransactionController do
  use MasonMoneyWallet.Web, :controller
  alias MasonMoneyWallet.Transaction

  def create(conn, params) do
    changeset = Transaction.changeset(%Transaction{}, params)
    if changeset.valid? do
      t = MasonMoneyWallet.Repo.insert! changeset
      conn
        |> send_resp(201, "")
    else
      conn
        |> put_status(:unprocessable_entity)
        |> render(MasonMoneyWallet.ChangesetView, "error.json", changeset)
    end
  end
end
