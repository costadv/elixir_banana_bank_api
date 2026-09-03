defmodule BananaBank.Users.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @field_list [:name, :password_hash, :email, :cep]

  schema "users" do
      field :name, :string
      field :password_hash, :string
      field :email, :string
      field :cep, :string

      timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @field_list)
    |> validate_required(@field_list)

  end
end
