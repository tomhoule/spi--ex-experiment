defmodule SpinozaEx.FragmentController do
  use SpinozaEx.Web, :controller
  require Logger

  alias SpinozaEx.Edition
  alias SpinozaEx.Fragment

  def edition(params) do
    @edition || Repo.get!(Edition, params["edition_id"])
  end

  def new(conn, params) do
    edition = Repo.get!(Edition, params["edition_id"])
    changeset = Fragment.changeset(%Fragment{}, %{edition_id: edition.id})
    Logger.log(:warn, inspect(changeset))
    render(conn, :new, changeset: changeset, edition: edition)
  end

  def create(conn, params) do
    %{"fragment" => fragment_params} = params
    changeset = Fragment.changeset(%Fragment{}, fragment_params)

    case Repo.insert(changeset) do
      {:ok, _fragment} ->
        conn
        |> put_flash(:info, "Thingy was successfully created")
        |> redirect(to: edition_path(conn, :edit, params["edition_id"]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, edition: edition(params))
    end
  end
end
