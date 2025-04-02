import React, { useState, useEffect } from "react";
import { io } from "socket.io-client";
import { v4 as uuidv4 } from "uuid";

const socket = io("ws://your-elixir-server:4000/socket");

export default function Chat() {
  const [username, setUsername] = useState(localStorage.getItem("username") || "");
  const [userId, setUserId] = useState(localStorage.getItem("userId") || uuidv4());
  const [loggedIn, setLoggedIn] = useState(!!username);
  const [users, setUsers] = useState([]);
  const [messages, setMessages] = useState([]);
  const [message, setMessage] = useState("");

  useEffect(() => {
    if (loggedIn) {
      socket.emit("user_joined", { username, userId });

      socket.on("update_users", (userList) => setUsers(userList));
      socket.on("new_message", (msg) => setMessages((prev) => [...prev, msg]));
    }

    return () => {
      socket.emit("user_left", { userId });
    };
  }, [loggedIn]);

  const sendMessage = () => {
    if (message.trim()) {
      socket.emit("new_message", { username, message });
      setMessage("");
    }
  };

  return loggedIn ? (
    <div className="max-w-lg mx-auto p-4 bg-gray-100 shadow-md rounded">
      <h2 className="text-2xl font-bold text-center">Chat Room</h2>
      <p className="text-gray-600 text-sm">Users Online: {users.length}</p>

      <div className="border p-2 h-64 overflow-y-scroll bg-white">
        {messages.map((msg, index) => (
          <div key={index} className="p-1 border-b">{msg}</div>
        ))}
      </div>

      <div className="flex mt-2">
        <input
          className="flex-grow border p-2 rounded"
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          placeholder="Type a message..."
        />
        <button onClick={sendMessage} className="bg-blue-500 text-white px-4 ml-2 rounded">Send</button>
      </div>
    </div>
  ) : (
    <div className="flex flex-col items-center p-4">
      <h2 className="text-2xl font-bold">Enter a Username</h2>
      <input
        className="border p-2 mt-2"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        placeholder="Username"
      />
      <button
        onClick={() => {
          localStorage.setItem("username", username);
          localStorage.setItem("userId", userId);
          setLoggedIn(true);
        }}
        className="bg-green-500 text-white px-4 mt-2 rounded"
      >
        Join
      </button>
    </div>
  );
}
