defmodule SpinozaEx.Fragment do
  use SpinozaEx.Web, :model

  schema "fragments" do
    field :path, :string
    field :text, :string
    belongs_to :edition, SpinozaEx.Edition

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    changeset = struct
    |> cast(params, [:path, :text, :edition_id])
    |> validate_required([:path, :text, :edition_id])
    |> validate_change(:path, &validate_path/2)
  end

  defp is_valid_fragment_path_part?(part) do
    case part do
      "aliter" -> true
      "axioma" -> true
      "definitio" -> true
      "pars" -> true
      "propositio" -> true
      "scholium" -> true
      "explanatio" -> true
      part -> match?(part, ~r/\d+/)
    end
  end

  def validate_path(:path, path) do
    starts_with_pars = String.starts_with?(path, "pars")
    fragments_are_valid = String.split(path, "/") |> Enum.all?(&is_valid_fragment_path_part?/1)
    cond do
      starts_with_pars && fragments_are_valid -> []
      starts_with_pars -> [path: "Fragments are not valid"]
      true -> [path: "Does not start with \"pars\""]
    end
  end
end
