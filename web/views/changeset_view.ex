defmodule Wallet.ChangesetView do
  use Wallet.Web, :view

  def render("error.json", changeset) do
    %{errors: Enum.into(changeset.errors, %{})}
  end
end
