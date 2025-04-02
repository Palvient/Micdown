import { Socket } from "phoenix";

const socket = new Socket("ws://your-elixir-server:4000/socket", { params: {} });
socket.connect();

const channel = socket.channel("chat:lobby", {});

channel.join()
  .receive("ok", () => console.log("Joined chat"))
  .receive("error", (reason) => console.log("Failed to join", reason));

export default channel;
