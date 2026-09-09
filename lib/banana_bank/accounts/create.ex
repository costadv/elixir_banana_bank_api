defmodule BananaBank.Accounts.Create do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias BananaBank.Users.Get, as: UserGet

  def call(%{"user_id" => id} = params) do
    case UserGet.call(id) do
      {:ok, _} -> create_account(params)
      {:error, error} -> {:error, error}
    end
  end

  defp create_account(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
