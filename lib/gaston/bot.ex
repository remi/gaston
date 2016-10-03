defmodule Gaston.Bot do
  use Slack

  # Constants
  @report_channel Application.get_env(:gaston, :report_channel)

  def handle_message(%{subtype: "message_deleted", channel: channel_or_group_id, previous_message: %{text: text, user: user_id}}, slack) do
    # Find the user and channel/group in the global `slack` map
    user = slack.users[user_id]
    channel_or_group = get_channel_or_group(channel_or_group_id, slack)

    # Report the deleted message
    handle_deleted_message(user, channel_or_group, text, slack)

    # Everything is cool
    :ok
  end

  def handle_message(%{subtype: "message_changed", channel: channel_or_group_id, message: %{text: new_text}, previous_message: %{text: old_text, user: user_id}}, slack) do
    # Find the user and channel/group in the global `slack` map
    user = slack.users[user_id]
    channel_or_group = get_channel_or_group(channel_or_group_id, slack)

    # Report the changed message
    handle_changed_message(user, channel_or_group, old_text, new_text, slack)

    # Everything is cool
    :ok
  end

  def handle_message(_, _), do: :ok

  defp get_channel_or_group(channel_or_group_id, slack) do
    channel_or_group = slack.channels[channel_or_group_id] || slack.groups[channel_or_group_id]
  end

  defp handle_deleted_message(%{name: username}, %{name: channel}, text, slack) do
    send_message(report_deleted_message(username, channel, text), @report_channel, slack)
  end

  defp handle_changed_message(%{name: username}, %{name: channel}, old_text, new_text, slack) do
    send_message(report_changed_message(username, channel, old_text, new_text), @report_channel, slack)
  end

  defp report_deleted_message(username, channel, text) do
    "@#{username} just deleted a message in ##{channel}:\n```\n#{text}\n```"
  end

  defp report_changed_message(username, channel, old_text, new_text) do
    "@#{username} just edited a message in ##{channel}:\nbefore:\n```\n#{old_text}\n```\nafter:\n```#{new_text}```"
  end
end
