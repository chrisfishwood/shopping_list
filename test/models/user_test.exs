defmodule ShoppingList.UserTest do
  use ShoppingList.ModelCase

  alias ShoppingList.User

  @valid_attrs %{email: "chrisfishwood@gmail.com", password_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
