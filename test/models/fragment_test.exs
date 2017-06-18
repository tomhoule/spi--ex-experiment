defmodule SpinozaEx.FragmentTest do
  use SpinozaEx.ModelCase

  alias SpinozaEx.Fragment

  @valid_attrs %{path: "pars.1.definitio.9", text: "some content", edition_id: 33}
  @invalid_attrs_because_of_path Map.update!(@valid_attrs, :path, fn _ -> "wow/such/path/much/ethics" end)
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Fragment.changeset(%Fragment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with valid attributes except path" do
    changeset = Fragment.changeset(%Fragment{}, @invalid_attrs_because_of_path)
    refute changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Fragment.changeset(%Fragment{}, @invalid_attrs)
    refute changeset.valid?
  end

  describe "#validate_path" do
    test "rejects paths that do not start with \"pars\"" do
      assert length(Fragment.validate_path(:path, "propositio")) === 1
    end

    test "accepts long paths with numbers and part names" do
      assert length(Fragment.validate_path(:path, "pars/1/propositio/33/scholium")) === 0
    end

    test "does not accept paths with unknown parts" do
      assert length(Fragment.validate_path(:path, "pars/1/heckingdoggobamboozle/33/scholium")) === 0
    end
  end
end
