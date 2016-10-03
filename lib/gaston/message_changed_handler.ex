defmodule Gaston.MessageChangedHandler do
  use Slack

  # Aliases
  alias Gaston.{Utils}

  def handle_message(%{channel: channel_or_group_id, message: %{text: new_text, user: user_id}, previous_message: %{text: old_text}}, slack) do
    # Find the user and channel/group in the global `slack` map
    user = slack.users[user_id]
    channel_or_group = Utils.get_channel_or_group(channel_or_group_id, slack)

    # Report the changed message
    do_handle_message(user, channel_or_group, old_text, new_text, slack)

    # Everything is cool
    :ok
  end

  defp do_handle_message(%{name: username}, %{name: channel}, old_text, new_text, slack) do
    report_channel = Application.get_env(:gaston, :report_channel);
    send_message(report_message(username, channel, old_text, new_text), report_channel, slack)
  end

  defp report_message(username, channel, old_text, new_text) do
    ":memo: @#{username} just edited a message in ##{channel}:\nbefore:\n```\n#{old_text}\n```\nafter:\n```#{new_text}```"
  end
end
