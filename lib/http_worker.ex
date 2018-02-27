defmodule EasyPotion.Http do
  use GenServer
  
  @doc """
  Starts a new http client worker.
  """
  def start_link do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def init(_opts) do
    {:ok, "Ready"}
  end

  def request(method, url) do
    :wpool.call(:http_workers, {:request, method, url}, :available_worker, :infinity)
  end

  def handle_call({:request, method, url}, _from, state) do
    result = :httpc.request(method, {to_charlist(url), []}, [{:timeout, :timer.seconds(4)}], [])
    {:reply, result, state}
  end

end