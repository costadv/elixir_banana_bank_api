defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _body} <- ViaCepClient.call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
      #|> handle_insert()
    end
  end

  #defp handle_insert({:ok, user}), do: user
  #defp handle_insert({:error, changeset}), do: changeset

end
