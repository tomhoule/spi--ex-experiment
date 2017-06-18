defmodule SpinozaEx.Repo.Migrations.CreateFragment do
  use Ecto.Migration

  def change do
    create table(:fragments) do
      add :path, :string
      add :text, :string
      add :edition_id, references(:editions, on_delete: :nothing)

      timestamps()
    end
    create index(:fragments, [:edition_id])

  end
end
