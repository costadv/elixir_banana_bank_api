defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params_create [:name, :password, :email, :cep]
  @required_params_update [:name, :email, :cep]

  schema "users" do
      field :name, :string
      field :password, :string, virtual: true
      field :password_hash, :string
      field :email, :string
      field :cep, :string

      timestamps()
  end

  def changeset_create(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params_create)
    |> validate_required(@required_params_create)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash()

  end

  def changeset_update(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params_update)
    |> validate_required(@required_params_update)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)

  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    #password_hash = Argon2.hash_pwd_salt(password)
    #change(changeset, password_hash: password_hash)
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end
  defp add_password_hash(changeset), do: changeset
end
