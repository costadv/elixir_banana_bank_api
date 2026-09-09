defmodule BananaBankWeb.AccountsController do
  use BananaBankWeb, :controller

  alias BananaBank.Accounts
  alias Accounts.Account

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
  def transaction(conn, %{"from_id" => from_id, "to_id" => to_id, "value" => value}) do
    with {:ok, _result} <- Accounts.transaction(from_id, to_id, value) do
      conn
      |> put_status(:ok)
      |> render(:transaction, %{"from_id" => from_id, "to_id" => to_id, "value" => value})
    end
  end

end
