defmodule BananaBankWeb.Token do
  alias Phoenix.Token
  alias BananaBankWeb.Endpoint

  @sign_salt "banana_bank_api"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{"user_id" => user.id}, max_age: 86400)
  end

  # if needed, can be used like this to handle other cases.
  # def verify(token) do
    # case Token.verify(Endpoint, @sign_salt, token) do
    #   {:ok, _result} = result -> result
    #   {:error, _} = error -> error
  #   end
  # end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
