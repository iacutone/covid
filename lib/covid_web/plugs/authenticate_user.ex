defmodule Covid.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Covid.Users
  alias Covid.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = Plug.Conn.get_session(conn, :current_user_id) do
      conn
    else
      conn
        |> put_flash(:error, "You are not allowed to access this page.")
        |> redirect(to: "/login")
        |> halt()
    end
  end
end
