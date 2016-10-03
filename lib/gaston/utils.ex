defmodule Gaston.Utils do
  def get_channel_or_group(channel_or_group_id, slack) do
    slack.channels[channel_or_group_id] || slack.groups[channel_or_group_id]
  end
end
