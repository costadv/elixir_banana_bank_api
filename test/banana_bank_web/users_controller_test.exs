defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "Successfully creates an user", %{conn: conn} do
      params = %{
        name: "test",
        cep: "12345678",
        email: "test@test.com",
        password: "123456"
      }

      response =
        conn
        #|> post(Routes.users_path(conn, :create), params)
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{"data" => %{
        "name" => "test",
        "cep" => "12345678",
        "email" => "test@test.com",
        "id" => _id
      }, "message" => "User created."} = response
    end
  end
end
