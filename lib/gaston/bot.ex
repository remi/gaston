defmodule Gaston.Bot do
  use Slack

  for channel <- Application.get_env(:gaston, :channels) do
    def handle_message(%{subtype: "message_deleted", channel: channel_or_group_id = unquote(channel), previous_message: %{text: text, user: user_id}}, slack) do
      # Find the user and channel/group in the global `slack` map
      user = slack.users[user_id]
      channel_or_group = slack.channels[channel_or_group_id] || slack.groups[channel_or_group_id]

      # Persist the message in the repo
      handle_deleted_message(user, channel_or_group, text)

      # Everything is cool
      :ok
    end
  end

  def handle_message(_,_), do: :ok

  defp handle_deleted_message(%{name: username}, %{name: channel}, text) do
    %Gaston.Message{username: username, text: text, channel: channel}
    |> Gaston.Repo.insert!
  end
end
