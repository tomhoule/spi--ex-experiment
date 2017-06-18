defmodule SpinozaEx.Edition do
  use SpinozaEx.Web, :model

  schema "editions" do
    field :title, :string
    field :year, :integer
    field :editor, :string
    field :language_code, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :year, :editor, :language_code])
    |> validate_required([:title, :year, :editor, :language_code])
  end
end
