defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account
  def create(%{account: account}) do
    %{
      message: "Account created.",
      data: data(account)
    }
  end

  def transaction(%{transaction: %{withdraw: source_account, deposit: target_account}}) do
    %{
      message: "Transaction completed successfully.",
      from_account: data(source_account),
      to_account: data(target_account)
    }
  end

  defp data(%Account{} = account) do
      %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
      }
  end
end
