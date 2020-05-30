defmodule Covid.Users.Auth do

  alias Covid.Users

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!Users.get_user!(user_id)
  end
end
