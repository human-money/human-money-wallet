defmodule MasonMoneyWallet.Router do
  use MasonMoneyWallet.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MasonMoneyWallet do
    get "/current_user", CurrentUserController, :show
    get "/users/:user_id", UserController, :show
  end

  scope "/", MasonMoneyWallet do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/profile", ProfileController, :edit
    post "/profile", ProfileController, :update
    get "/transactions", TransactionController, :index
  end

  scope "/auth", MasonMoneyWallet do
    pipe_through :browser

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
