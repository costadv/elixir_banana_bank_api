defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "Returns valid cep information", %{bypass: bypass} do
      cep = "01001000"
      expected_body = ~s({
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "unidade": "",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "estado": "São Paulo",
        "regiao": "Sudeste",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })

      expected_response = {:ok,
        %{"bairro" => "Sé",
          "cep" => "01001-000",
          "complemento" => "lado ímpar",
          "ddd" => "11",
          "estado" => "São Paulo",
          "gia" => "1004",
          "ibge" => "3550308",
          "localidade" => "São Paulo",
          "logradouro" => "Praça da Sé",
          "regiao" => "Sudeste",
          "siafi" => "7107",
          "uf" => "SP",
          "unidade" => ""
        }
      }

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, expected_body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response

    end

  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"

end
