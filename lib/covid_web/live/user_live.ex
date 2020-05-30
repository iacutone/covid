defmodule CovidWeb.UserLive do
  use CovidWeb, :live_view

  alias Covid.Users
  alias Covid.Users.User

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        current_user: signed_in?(session),
        changeset: Users.change_user(%User{}),
        sign_in_form: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= if @current_user do %>
    <% else %>
      <%= if @sign_in_form do %>
        <h2>Sign Up</h2>

        <form phx-submit="sign_in_form">
          <button>
            Sign In
          </button>
        </form>

        <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :sign_up] %>
          <%= label f, :email %>
          <%= email_input f, :email %>
          <%= error_tag f, :email %>

          <%= label f, :password %>
          <%= password_input f, :password %>
          <%= error_tag f, :password %>

          <%= label f, :password_confirmation %>
          <%= password_input f, :password_confirmation %>
          <%= error_tag f, :password_confirmation %>

          <%= submit "Sign Up" %>
        </form>
      <% else %>
        <h2>Sign In</h2>

        <form phx-submit="sign_up_form">
          <button>
            Sign Up
          </button>
        </form>

        <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :sign_in] %>
          <%= label f, :email %>
          <%= email_input f, :email %>
          <%= error_tag f, :email %>

          <%= label f, :password %>
          <%= password_input f, :password %>
          <%= error_tag f, :password %>

          <%= submit "Sign In" %>
        </form>
      <% end %>
    <% end %>
    """
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Users.change_user(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("sign_up", %{"user" => user_params}, socket) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        {:noreply,
          socket
          |> put_flash(:info, "User created")
          |> redirect(to: "/company")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("sign_up_form", _params, socket) do
    {:noreply, assign(socket, sign_in_form: true)}
  end

  def handle_event("sign_in_form", _params, socket) do
    {:noreply, assign(socket, sign_in_form: false)}
  end

  def handle_event("sign_in", %{"user" => user_params}, socket) do
    user = Users.get_by_email(user_params["email"])

    case Comeonin.Bcrypt.check_pass(user, user_params["password"]) do
      {:ok, user} ->
        {:noreply,
          socket
          |> put_flash(:info, "Successfully signed in #{user.email}")
          |> redirect(to: "/company")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def signed_in?(session) do
    IO.inspect session
    false
    # user_id = Plug.Conn.get_session(conn, :current_user_id)
    # if user_id, do: !!Accounts.get_user!(user_id)
  end
end
