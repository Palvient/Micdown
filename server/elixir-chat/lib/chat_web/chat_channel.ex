defmodule ChatWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    broadcast(socket, "update_users", Chat.Users.list_users())
    {:noreply, socket}
  end

  def handle_in("user_joined", %{"username" => username, "userId" => userId}, socket) do
    Chat.Users.add_user(userId, username)
    broadcast(socket, "update_users", Chat.Users.list_users())
    {:noreply, socket}
  end

  def handle_in("user_left", %{"userId" => userId}, socket) do
    Chat.Users.remove_user(userId)
    broadcast(socket, "update_users", Chat.Users.list_users())
    {:noreply, socket}
  end

  def handle_in("new_message", %{"username" => username, "message" => message}, socket) do
    broadcast(socket, "new_message", "#{username}: #{message}")
    {:noreply, socket}
  end
end
