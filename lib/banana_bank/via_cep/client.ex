defmodule BananaBank.ViaCep.Client do
  #use Tesla
  @client Tesla.client([
    {Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"},
    Tesla.Middleware.JSON
    ])

  def call(cep) do
    @client
    |> Tesla.get("/#{cep}/json/")
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}), do: {:error, :not_found}
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 400}}), do: {:error, :bad_request}
end
