defmodule SpinozaEx.EditionControllerTest do
  use SpinozaEx.ConnCase

  alias SpinozaEx.Edition
  @valid_attrs %{editor: "some content", language_code: "some content", title: "some content", year: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, edition_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing editions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, edition_path(conn, :new)
    assert html_response(conn, 200) =~ "New edition"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, edition_path(conn, :create), edition: @valid_attrs
    assert redirected_to(conn) == edition_path(conn, :index)
    assert Repo.get_by(Edition, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, edition_path(conn, :create), edition: @invalid_attrs
    assert html_response(conn, 200) =~ "New edition"
  end

  test "shows chosen resource", %{conn: conn} do
    edition = Repo.insert! %Edition{}
    conn = get conn, edition_path(conn, :show, edition)
    assert html_response(conn, 200) =~ "Show edition"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, edition_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    edition = Repo.insert! %Edition{}
    conn = get conn, edition_path(conn, :edit, edition)
    assert html_response(conn, 200) =~ "Edit edition"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    edition = Repo.insert! %Edition{}
    conn = put conn, edition_path(conn, :update, edition), edition: @valid_attrs
    assert redirected_to(conn) == edition_path(conn, :show, edition)
    assert Repo.get_by(Edition, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    edition = Repo.insert! %Edition{}
    conn = put conn, edition_path(conn, :update, edition), edition: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit edition"
  end

  test "deletes chosen resource", %{conn: conn} do
    edition = Repo.insert! %Edition{}
    conn = delete conn, edition_path(conn, :delete, edition)
    assert redirected_to(conn) == edition_path(conn, :index)
    refute Repo.get(Edition, edition.id)
  end
end
