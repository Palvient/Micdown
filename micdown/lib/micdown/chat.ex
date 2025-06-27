defmodule Micdown.Chat do
  import Ecto.Query, warn: false
  alias Micdown.Repo
  alias Micdown.Chat.Message

  def list_messages_between(user1_id, user2_id) do
    from(m in Message,
      where: (m.sender_id == ^user1_id and m.receiver_id == ^user2_id)
          or (m.sender_id == ^user2_id and m.receiver_id == ^user1_id),
      order_by: [asc: m.inserted_at]
    )
    |> Repo.all()
  end

  def send_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end
end
