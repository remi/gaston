defmodule Gaston.Message.Schema do
  use Ecto.Schema

  schema "messages" do
    field :username
    field :text
    field :channel

    timestamps
  end
end
