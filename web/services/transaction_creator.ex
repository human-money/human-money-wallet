defmodule Wallet.Services.TransactionCreator do
  alias Wallet.Repo
  alias Wallet.Transaction

  def create(current_user_id, transaction_params) do
    changeset = Transaction.changeset(
      %Transaction{
        from_user_id: current_user_id
      },
      transaction_params
    )

    case Repo.insert(changeset) do
      {:ok, transaction} ->
        {:ok, transaction}
      error -> error
    end
  end
end
