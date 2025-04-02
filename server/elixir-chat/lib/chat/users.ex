defmodule Chat.Users do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def add_user(user_id, username) do
    Agent.update(__MODULE__, &Map.put(&1, user_id, username))
  end

  def remove_user(user_id) do
    Agent.update(__MODULE__, &Map.delete(&1, user_id))
  end

  def list_users do
    Agent.get(__MODULE__, &Map.values(&1))
  end
end
