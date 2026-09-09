defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Create
  alias BananaBank.Accounts.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(source_account_id, target_account_id, value), to: Transaction, as: :call
end
