defmodule Gaston.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :username, :string, null: false
      add :text, :text, null: false
      add :channel, :string, null: false

      timestamps
    end
  end
end
