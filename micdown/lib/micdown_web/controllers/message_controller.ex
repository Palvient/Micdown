defmodule MicdownWeb.MessageController do
  use MicdownWeb, :controller
  alias Micdown.Chat

  def index(conn, %{"user_id" => user_id}) do
    current_user_id = conn.assigns.current_user.id
    messages = Chat.list_messages_between(current_user_id, String.to_integer(user_id))
    render(conn, "index.html", messages: messages, receiver_id: user_id)
  end

  def create(conn, %{"message" => %{"receiver_id" => receiver_id, "content" => content}}) do
    sender_id = conn.assigns.current_user.id

    case Chat.send_message(%{
           sender_id: sender_id,
           receiver_id: receiver_id,
           content: content
         }) do
      {:ok, _msg} ->
        redirect(conn, to: Routes.message_path(conn, :index, receiver_id))

      {:error, _changeset} ->
        conn |> put_flash(:error, "Message failed.") |> redirect(to: "/")
    end
  end
end
