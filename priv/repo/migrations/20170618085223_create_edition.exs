defmodule SpinozaEx.Repo.Migrations.CreateEdition do
  use Ecto.Migration

  def change do
    create table(:editions) do
      add :title, :string
      add :year, :integer
      add :editor, :string
      add :language_code, :string

      timestamps()
    end

  end
end
