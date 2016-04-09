defmodule Wallet.TransactionController do
  use Wallet.Web, :controller
  alias Wallet.Transaction
  alias Wallet.Services.TransactionCreator

  def index(conn, params) do
    query = from t in Transaction,
      order_by: [desc: t.inserted_at]

    render conn, "index.json", data: Repo.all(query)
  end

  def create(conn, params) do
    conn = fetch_session(conn)
    current_user_id = get_session(conn, :current_user_id)
    changeset = Transaction.changeset(%Transaction{from_user_id: current_user_id}, params)
    if changeset.valid? do
      t = Wallet.Repo.insert! changeset
      conn
        |> send_resp(201, "")
    else
      conn
        |> put_status(:unprocessable_entity)
        |> render(Wallet.ChangesetView, "error.json", changeset)
    end
  end
end
