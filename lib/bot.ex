defmodule Gaston.Bot do
  use Slack

  for channel <- Application.get_env(:gaston, :channels) do
    def handle_message(%{subtype: "message_deleted", channel: channel = unquote(channel), previous_message: %{text: text, user: user}}, slack) do
      handle_deleted_message(user, text, channel, slack)
    end
  end

  def handle_message(_,_), do: :ok

  defp handle_deleted_message(user, text, channel, slack) do
    username = get_in(Slack.Web.Users.info(user), ["user", "name"])
    send_message("User @#{username} just deleted the following message: \n```#{text}\n```", channel, slack)
  end
end
