defmodule Wallet.Services.TransactionCreator do
  alias Ecto.Changeset
  alias Wallet.Repo
  alias Wallet.Transaction
  alias Wallet.Services.DestinationAssigner
  alias Wallet.Services.Bitcoin

  def create(current_user_id, transaction_params) do
    changeset = Transaction.changeset(
      %Transaction{
        source_user_id: current_user_id
      },
      transaction_params
    )

    changeset = DestinationAssigner.set_destination(
      changeset,
      transaction_params["destination"]
    )

    case Repo.insert(changeset) do
      {:ok, transaction} ->
        Bitcoin.deliver(transaction)
        {:ok, transaction}
      error -> error
    end
  end
end
