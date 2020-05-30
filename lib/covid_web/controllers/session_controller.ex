defmodule CovidWeb.SessionController do
  use CovidWeb, :controller

  alias Covid.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    user = Users.get_by_email(auth_params["email"])
    case Comeonin.Bcrypt.check_pass(user, auth_params["password"]) do
    {:ok, user} ->
      conn
      |> put_session(:current_user_id, user.id)
      |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: "/company")
    {:error, _} ->
      conn
      |> put_flash(:error, "There was a problem with your username/password")
      |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
