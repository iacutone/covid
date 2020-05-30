defmodule CovidWeb.ReportsLive do
  use CovidWeb, :live_view

  alias Covid.Companies.Company
  alias Covid.Repo
  alias Covid.Users

  def mount(params, session, socket) do
    user = Users.get_user!(session["current_user_id"]) |> Repo.preload(company: [questionnaires: [:worker, batteries: [:question]]])
    socket =
      assign(socket,
        current_user: user,
        company: user.company,
        questionnaires: user.company.questionnaires
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <table>
      <thead>
        <tr>
          <th>Employee Name</th>
          <th>Date</th>
          <th>Question</th>
          <th>Question Response</th>
        </tr>
      </thead>
      <tbody>
        <%= for q <- @questionnaires do %>
          <tr>
            <td><%= q.worker.name %></td>
            <td><%= q.inserted_at %></td>
            <%= Enum.map(q.batteries, fn b -> 
                id = [content_tag(:td, b.question.query)]
                verified = [content_tag(:td, b.verified)]
              [id, verified]
            end) %>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
