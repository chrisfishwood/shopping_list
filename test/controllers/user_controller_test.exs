defmodule ShoppingList.UserControllerTest do
  use ShoppingList.ConnCase
  require IEx

  alias ShoppingList.User
  @valid_attrs_virtual %{email: "chrisfishwood@gmail.com", password: "somepassword"}
  @valid_attrs %{email: "chrisfishwood@gmail.com"}
  @invalid_attrs %{email: nil}

  test "lists all entries on index", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "renders form for new resources", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs_virtual
    user = Guardian.Plug.current_resource(conn)
    assert redirected_to(conn) == user_path(conn, :show, user.id)
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

  test "shows chosen resource", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = get conn, user_path(conn, :show, user.id)
    assert html_response(conn, 200) =~ "Show user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    assert_error_sent 404, fn ->
      conn = get conn, user_path(conn, :show, "11111111-1111-1111-1111-111111111111")
      IEx.pry
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = put conn, user_path(conn, :update, user), user: Map.merge(@valid_attrs_virtual, %{email: "test@test.com"})
    assert redirected_to(conn) == user_path(conn, :show, user)
    assert Repo.get_by(User, %{email: "test@test.com"})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{conn: conn} do
    changeset = User.changeset(%User{}, @valid_attrs_virtual)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)

    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
