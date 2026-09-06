defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users
  alias Users.User
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

    test "Invalid parameters for creating user", %{conn: conn} do
      params = %{
        name: "te",
        cep: "1234567",
        email: "testtest.com",
        password: "123456"
      }

      response =
        conn
        #|> post(Routes.users_path(conn, :create), params)
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
           "email" => ["has invalid format"],
            "name" => ["should be at least 3 character(s)"]
        }
      } = response
    end
  end

  describe "delete/2" do
    test "Successfully deletes an user", %{conn: conn} do
      params = %{
        name: "test",
        cep: "12345678",
        email: "test@test.com",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      assert %{"data" => %{
        "name" => "test",
        "cep" => "12345678",
        "email" => "test@test.com",
        "id" => _id
      }, "message" => "User deleted."} = response
    end
  end
end
