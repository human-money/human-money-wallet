defmodule Wallet.TransactionController do
  use Wallet.Web, :controller
  alias Wallet.Transaction
  alias Wallet.TransactionView
  alias Wallet.Services.TransactionCreator
  alias Wallet.ChangesetView

  def index(conn, params) do
    conn = fetch_session(conn)
    current_user_id = get_session(conn, :current_user_id)
    query = from t in Transaction,
      where: (t.source_user_id == ^current_user_id or t.destination_user_id == ^current_user_id),
      order_by: [desc: t.inserted_at]

    render conn, "index.json", data: Repo.all(query)
  end

  def create(conn, transaction_params) do
    conn = fetch_session(conn)
    current_user_id = get_session(conn, :current_user_id)

    case TransactionCreator.create(current_user_id, transaction_params) do
      {:ok, transaction} ->
        Wallet.Endpoint.broadcast!(
          "update",
          "transaction:add",
          TransactionView.render("show.json", %{data: transaction})
        )
        conn
        |> send_resp(:created, "")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
 end
end
