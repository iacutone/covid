defmodule CovidWeb.WorkerLive do
  use CovidWeb, :live_view

  alias Covid.Workers

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        workers: Workers.list_workers()
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Workers</h1>

    <%= for worker <- @workers do %>
      <strong><%= worker.name %></strong>
      <span>Current?</span>
      <input phx-click="toggle-active" type="checkbox" name="worker_id" phx-value-worker_id="<%= worker.id %>" value="<%= worker.id %>"
        <%= if worker.current == true do %>checked<% end %> 
      >
      <br>
    <% end %>

    <h2>Add a Worker</h2>
    <form phx-submit="add-worker">
      <input type="text" name="worker" placeholder="Add a worker name">

      <br>
      <button type="submit">
        Submit
      </button>
    </form>
    """
  end

  def handle_event("toggle-active", %{"worker_id" => id}, socket) do
    worker = Workers.get_worker!(id)
    Workers.update_worker(worker, %{current: !worker.current})
    {:noreply, assign(socket, workers: Workers.list_workers())}
  end

  def handle_event("add-worker", %{"worker" => name}, socket) do
    Workers.create_worker(%{name: name, current: true, company_id: 1})
    {:noreply, assign(socket, workers: Workers.list_workers())}
  end
end
