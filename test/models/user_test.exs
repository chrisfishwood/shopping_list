defmodule AuthExample.UserTest do
  use AuthExample.ModelCase

  alias AuthExample.User

  @valid_attrs_virtual %{email: "chrisfishwood@gmail.com", password: "foo"}
  @valid_attrs %{email: "chrisfishwood@gmail.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "passwords are hashed" do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    assert changeset.valid?
    assert  Comeonin.Bcrypt.checkpw(@valid_attrs_virtual.password, changeset.changes.password_hash)
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
