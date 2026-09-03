defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert(_) do

  end

end
