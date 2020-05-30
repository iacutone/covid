defmodule CovidWeb.QuestionnaireLive do
  use CovidWeb, :live_view

  alias Covid.Batteries
  alias Covid.Questions
  alias Covid.Questionnaires
  alias Covid.Repo
  alias Covid.Users
  alias Covid.Workers

  def mount(params, session, socket) do
    user = Users.get_user!(session["current_user_id"]) |> Repo.preload(:company)

    socket =
      assign(socket,
        company: user.company,
        questions: Questions.active_questions(),
        name: "",
        matches: [],
        worker_id: nil,
        loading: false,
        search_disabled: false,
        hide_form: true,
        submit_button_disabled: true,
        search_phrase: ""
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1><%= @company.name %></h1>

    <h2>Questionnaire</h2>

    <%= label(:company, :name) %>
    <%= form_tag "#", [phx_change: :search] %>
      <%= text_input :search, :phrase, value: @search_phrase, disabled: @search_disabled, placeholder: "Search for a worker" %>
      <%= hidden_input :search, :company_id, value: @company.id %>
    </form>

    <%= if @search_disabled do %>
      <a href="#" class="btn" phx-click="enable">Enable Worker Search</a>
    <% end %>

    <%= if @matches != [] do %>
      <%= for match <- @matches do %>
        <div phx-click="select" phx-value-id="<%= match.id %>">
          <%= match.name %>
        </div>
      <% end %>
    <% end %>

    <%= if !@hide_form do %>
      <form phx-submit="submit">
        <%= for question <- @questions do %>
          <label for="query"><%= question.query %></label>

          <input type="radio" name="questions[<%= question.id %>]" value="yes" required>Yes
          <input type="radio" name="questions[<%= question.id %>]" value="no" required>No
          <input type="hidden" name="worker_id" value="<%= @worker_id %>">
        <% end %>

        <br>
        <button>Submit</button>
      </form>
    <% end %>
    """
  end

  def handle_event("submit", %{"questions" => questions, "worker_id" => worker_id}, socket) do
    {:ok, questionnaire} = Questionnaires.create_questionnaire(%{worker_id: worker_id})
    Enum.each(questions, fn{question_id, response} -> 
      Batteries.create_battery(%{question_id: question_id, questionnaire_id: questionnaire.id, verified: response_map(response)})
    end)

    socket =
      assign(socket,
        questions: Questions.active_questions(),
        name: "",
        matches: [],
        worker_id: nil,
        loading: false,
        search_disabled: false,
        hide_form: true,
        submit_button_disabled: true,
        search_phrase: ""
      )

    {:noreply, socket}
  end

  defp response_map(response) do
    case response do
      "yes" ->
        true
      "no" ->
        false
    end
  end

  def handle_event("search", %{"search" => search}, socket) do
    assigns = [
      matches: Workers.search(
        search["phrase"], 
        search["company_id"]
      ),
      search_phrase: search["phrase"]
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("select", %{"id" => worker_id}, socket) do
    worker = Covid.Workers.get_worker!(worker_id)
    assigns = [
      matches: [],
      search_phrase: worker.name,
      worker_id: worker.id,
      search_disabled: true,
      hide_form: false
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("enable", _, socket) do
    assigns = [
      matches: [],
      search_phrase: "",
      search_disabled: false,
      hide_form: true,
      worker_id: nil
    ]

    {:noreply, assign(socket, assigns)}
  end
end
