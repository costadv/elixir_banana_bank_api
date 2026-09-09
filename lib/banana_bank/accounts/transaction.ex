defmodule BananaBank.Accounts.Transaction do

  alias BananaBank.Repo
  alias BananaBank.Accounts
  alias Accounts.Account
  alias Ecto.Multi

  def call(%{"from_id" => source_account_id, "to_id" => target_account_id, "value" => value}) do
    with {:ok, source_account} <- check_account(source_account_id),
      {:ok, target_account} <- check_account(target_account_id),
      {:ok, value} <- Decimal.cast(value) do
        Multi.new()
        |> withdraw(source_account, value)
        |> deposit(target_account, value)
        |> Repo.transact()
        |> handle_transaction()
    else
      nil -> {:error, :not_found}
      :error -> {:error, :invalid_value}
    end
  end

  def call(_) do
    {:error, :no_params}
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

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, :withdraw, _reason, _}), do: {:error, :withdraw}
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}

end
