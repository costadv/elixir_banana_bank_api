defmodule BananaBank.ViaCep.Client do
  #use Tesla
  @client Tesla.client([
    Tesla.Middleware.JSON
    ])
  @default_url "https://viacep.com.br/ws/"

  def call(url \\ @default_url, cep) do
    @client
    |> Tesla.get("#{url}#{cep}/json/")
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}), do: {:error, :cep_invalido}
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 400}}), do: {:error, :cep_invalido}
end
