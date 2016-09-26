defmodule Gaston.Message do
  use Ecto.Schema

  schema "messages" do
    field :username
    field :text
    field :channel

    timestamps
  end
end
