defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :password, :email, :cep]

  schema "users" do
      field :name, :string
      field :password, :string, virtual: true
      field :password_hash, :string
      field :email, :string
      field :cep, :string

      timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash()
    |> IO.inspect()

  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    password_hash = Argon2.hash_pwd_salt(password)
    IO.inspect(password_hash)
    IO.puts("password hash feito")
    change(changeset, password_hash: password_hash)
  end
  defp add_password_hash(changeset), do: changeset
end
