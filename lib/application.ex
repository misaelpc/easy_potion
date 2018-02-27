defmodule EasyPotion.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    :inets.start
		:ssl.start
    opts = [{:overrun_warning, :infinity},
        {:overrun_handler, {:error_logger, :warning_report}},
        {:workers, 200},
        {:worker_opt, []},
        {:worker, {EasyPotion.Http, []}}]

    children = [
      worker(:wpool_pool, [:http_workers, opts], [id: make_ref()])
    ]

    opts = [strategy: :one_for_one, name: Counter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end