defmodule Gaston.MessageDeletedHandler do
  use Slack

  # Aliases
  alias Gaston.{Utils}

  def handle_message(%{channel: channel_or_group_id, previous_message: %{text: text, user: user_id}}, slack) do
    # Find the user and channel/group in the global `slack` map
    user = slack.users[user_id]
    channel_or_group = Utils.get_channel_or_group(channel_or_group_id, slack)

    # Report the deleted message
    do_handle_message(user, channel_or_group, text, slack)

    # Everything is cool
    :ok
  end

  defp do_handle_message(%{name: username}, %{name: channel}, text, slack) do
    report_channel = Application.get_env(:gaston, :report_channel)
    send_message(report_message(username, channel, text), report_channel, slack)
  end

  defp report_message(username, channel, text) do
    ":x: @#{username} just deleted a message in ##{channel}:\n```\n#{text}\n```"
  end
end
