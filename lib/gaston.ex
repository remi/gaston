defmodule Gaston do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [worker(Gaston.Bot, [Application.get_env(:slack, :api_token)])]
    opts = [strategy: :one_for_one, name: Gaston.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
