defmodule SpinozaEx.EditionController do
  use SpinozaEx.Web, :controller

  alias SpinozaEx.Edition
  alias SpinozaEx.Fragment

  def index(conn, _params) do
    editions = Repo.all(Edition)
    render(conn, "index.html", editions: editions)
  end

  def new(conn, _params) do
    changeset = Edition.changeset(%Edition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"edition" => edition_params}) do
    changeset = Edition.changeset(%Edition{}, edition_params)

    case Repo.insert(changeset) do
      {:ok, _edition} ->
        conn
        |> put_flash(:info, "Edition created successfully.")
        |> redirect(to: edition_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp fragments(id) do
    fragments = from f in Fragment,
      where: f.edition_id == ^id,
      select: f
  end

  def show(conn, %{"id" => id}) do
    edition = Repo.get!(Edition, id)
    render(conn, "show.html", edition: edition, fragments: fragments(id) |> Repo.all)
  end

  def edit(conn, %{"id" => id}) do
    edition = Repo.get!(Edition, id)
    changeset = Edition.changeset(edition)
    render(conn, "edit.html", edition: edition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "edition" => edition_params}) do
    edition = Repo.get!(Edition, id)
    changeset = Edition.changeset(edition, edition_params)

    case Repo.update(changeset) do
      {:ok, edition} ->
        conn
        |> put_flash(:info, "Edition updated successfully.")
        |> redirect(to: edition_path(conn, :show, edition))
      {:error, changeset} ->
        render(conn, "edit.html", edition: edition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    edition = Repo.get!(Edition, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(edition)

    conn
    |> put_flash(:info, "Edition deleted successfully.")
    |> redirect(to: edition_path(conn, :index))
  end
end
