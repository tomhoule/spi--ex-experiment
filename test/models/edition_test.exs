defmodule SpinozaEx.EditionTest do
  use SpinozaEx.ModelCase

  alias SpinozaEx.Edition

  @valid_attrs %{editor: "some content", language_code: "some content", title: "some content", year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Edition.changeset(%Edition{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Edition.changeset(%Edition{}, @invalid_attrs)
    refute changeset.valid?
  end
end
