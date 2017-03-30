defmodule ShoppingList.UserControllerTest do
  use ShoppingList.ConnCase

  alias ShoppingList.User
  @valid_attrs %{email: "chrisfishwood@gmail.com", password: "somepassword"}
  @invalid_attrs %{email: nil}

  setup do
    changeset = User.changeset(%User{}, @valid_attrs)
    {:ok, user} = Repo.insert(changeset)
    conn = guardian_login(user)
    {:ok, [user: user, conn: conn]}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: Map.merge(@valid_attrs, %{email: "test@test.com"})
    user = Guardian.Plug.current_resource(conn)
    assert redirected_to(conn) == user_path(conn, :show, user.id)
    assert Repo.get_by(User, %{email: "test@test.com"})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

  test "shows chosen resource", %{user: user, conn: conn} do
    conn = get conn, user_path(conn, :show, user.id)

    assert html_response(conn, 200) =~ "Show user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{user: user, conn: conn} do
    conn = get conn, user_path(conn, :edit, user)

    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{user: user, conn: conn} do
    conn = put conn, user_path(conn, :update, user), user: Map.merge(@valid_attrs, %{email: "test@test.com"})

    assert redirected_to(conn) == user_path(conn, :show, user)
    assert Repo.get_by(User, %{email: "test@test.com"})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{user: user, conn: conn} do
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{user: user, conn: conn} do
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
