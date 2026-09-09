defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account
  def create(%{account: account}) do
    %{
      message: "Account created.",
      data: data(account)
    }
  end

  def transaction(%{"from_id" => from_id, "to_id" => to_id, "value" => value}) do
    %{message: "Transfered #{value} from account #{from_id} to account #{to_id} successfully."}
  end

  defp data(%Account{} = account) do
      %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
      }
  end
end
