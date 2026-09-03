defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, user}), do: user
  defp handle_insert({:error, changeset}), do: changeset

end
