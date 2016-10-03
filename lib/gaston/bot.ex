defmodule Gaston.Bot do
  use Slack

  # Alias
  alias Gaston.{MessageDeletedHandler, MessageChangedHandler}

  def handle_message(message = %{subtype: "message_deleted"}, slack) do
    MessageDeletedHandler.handle_message(message, slack)
  end

  def handle_message(message = %{subtype: "message_changed"}, slack) do
    MessageChangedHandler.handle_message(message, slack)
  end

  def handle_message(_, _), do: :ok
end
