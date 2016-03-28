defmodule MasonMoneyWallet.ChangesetView do
  use MasonMoneyWallet.Web, :view

  def render("error.json", changeset) do
    %{errors: Enum.into(changeset.errors, %{})}
  end
end
