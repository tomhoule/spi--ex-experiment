defmodule SpinozaEx.PageController do
  use SpinozaEx.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
