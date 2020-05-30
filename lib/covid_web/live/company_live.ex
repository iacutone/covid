defmodule CovidWeb.CompanyLive do
  use CovidWeb, :live_view

  alias Covid.Companies
  alias Covid.Companies.Company
  alias Covid.Repo
  alias Covid.Users

  def mount(params, session, socket) do
    user = Users.get_user!(session["current_user_id"]) |> Repo.preload(:company)
    socket =
      assign(socket,
        current_user: user,
        company: user.company,
        changeset: Companies.change_company(%Company{}),
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= if @company do %>
      <h1><%= @company.name %></h1>

      <%= link "Questionnaire", to: Routes.live_path(@socket, CovidWeb.QuestionnaireLive) %>
      <br>
      <%= link "Add/Edit Workers", to: Routes.live_path(@socket, CovidWeb.WorkerLive) %>
    <% else %>
      <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :submit] %>
        <%= label f, :company_name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= hidden_input f, :user_id, value: @current_user.id %>

        <%= submit "Submit" %>
      </form>
    <% end %>
    """
  end

  def handle_event("validate", %{"company" => company_params}, socket) do
    changeset =
      %Company{}
      |> Companies.change_company(company_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("submit", %{"company" => company_params}, socket) do
    case Companies.create_company(company_params) do
      {:ok, company} ->
        {:noreply,
          socket
          |> put_flash(:info, "Company created")
          |> redirect(to: "/company")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
