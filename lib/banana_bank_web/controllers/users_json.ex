defmodule BananaBankWeb.UsersJSON do
  def create(%{user: user}) do
    %{
      message: "User created.",
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
