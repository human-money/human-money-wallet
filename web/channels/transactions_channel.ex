defmodule Wallet.TransactionChannel do
  use Phoenix.Channel

  def join("update", _message, socket) do
    {:ok, socket}
  end

  def join("transactions:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
