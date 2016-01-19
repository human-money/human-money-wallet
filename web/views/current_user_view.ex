defmodule MasonMoneyWallet.CurrentUserView do
  use MasonMoneyWallet.Web, :view
  @attributes ~W(id)

  def render("show.json", %{data: data}) do
    data
    |> Map.take([:public_key, :private_key])
  end
end