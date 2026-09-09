defmodule BananaBank.Accounts.Transaction do

  alias BananaBank.Repo
  alias BananaBank.Accounts
  alias Accounts.Account
  alias Ecto.Multi

  def call(source_account_id, target_account_id, value) do
    with {:ok, source_account} <- check_account(source_account_id),
      {:ok, target_account} <- check_account(target_account_id),
      {:ok, value} <- Decimal.cast(value) do
        Multi.new()
        |> withdraw(source_account, value)
        |> deposit(target_account, value)
        |> Repo.transact()
    else
      nil -> {:error, :not_found}
      :error -> {:error, :invalid_value}
    end
  end

  defp check_account(id) do
    case Repo.get(Account, id) do
      nil -> nil
      account -> {:ok, account}
    end
  end

  defp withdraw(multi, account, value) do
    new_balance = Decimal.sub(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, account, value) do
    new_balance = Decimal.add(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)

  end
end
