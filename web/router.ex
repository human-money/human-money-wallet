defmodule Wallet.Router do
  use Wallet.Web, :router

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

  scope "/api", Wallet do
    pipe_through :api
    get "/current_user", CurrentUserController, :show
    get "/users/:user_id", UserController, :show
    post "/transactions", TransactionController, :create
    get "/transactions", TransactionController, :index
  end

  scope "/auth", Wallet do
    pipe_through :browser

    get "/sign_out", AuthController, :delete
    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
  end

  scope "/", Wallet do
    pipe_through :browser

    get "/", RootController, :show
    get "/*path", HomeController, :index
  end



  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
