defmodule Wallet.CurrentUserView do
  use Wallet.Web, :view
  @attributes ~W(id)

  def render("show.json", %{data: data}) do
    data
    |> Map.take([
      :id,
      :username,
      :public_key,
      :private_key
    ])
  end
end
