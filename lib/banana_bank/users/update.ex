defmodule BananaBank.Users.Update do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(%{"id" => id} = params) do
     case length(Map.keys(params)) do
       1 -> {:error, :no_params}
       _ -> get_user(params)
     end
  end

  defp get_user(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> update(user, params)

    end
  end

  defp update(user, params) do
    user
    |> User.changeset_update(params)
    |> Repo.update()
  end
end
