defmodule MasonMoneyWallet.AuthController do
  use MasonMoneyWallet.Web, :controller

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => provider, "code" => code}) do
    # Exchange an auth code for an access token
    token = get_token!(provider, code)

    # Request the user's data with the access token
    oauth_user = get_user!(provider, token)

    if Repo.get_by(MasonMoneyWallet.User, facebook_id: oauth_user[:id]) do
      user = Repo.get_by(MasonMoneyWallet.User, facebook_id: oauth_user[:id])
      conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/transactions")
    else
      user = %MasonMoneyWallet.User{}
      {:nacl_box_keypair, public_key, private_key} = :nacl.box_keypair()

      keys = %{private_key: Base.encode16(private_key)}
      user = Map.merge(user, keys)
      user = Map.merge(user, %{facebook_id: oauth_user[:id]})
      user = MasonMoneyWallet.Repo.insert! user

      conn
      |> put_session(:current_user_id, user.id)
      |> redirect(to: "/profile")
    end
  end

  defp authorize_url!("github"),   do: GitHub.authorize_url!
  defp authorize_url!("google"),   do: Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")
  defp authorize_url!("facebook"), do: Facebook.authorize_url!(scope: "user_photos")
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("github", code),   do: GitHub.get_token!(code: code)
  defp get_token!("google", code),   do: Google.get_token!(code: code)
  defp get_token!("facebook", code), do: Facebook.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_user!("github", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "/user")
    %{name: user["name"], avatar: user["avatar_url"]}
  end
  defp get_user!("google", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")
    %{name: user["name"], avatar: user["picture"]}
  end
  defp get_user!("facebook", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "/me", fields: "id,name")
    %{id: user["id"], name: user["name"], avatar: "https://graph.facebook.com/#{user["id"]}/picture"}
  end
end
