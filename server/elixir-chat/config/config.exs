import Config

config :chat, ChatWeb.Endpoint,
  http: [port: 4000],
  secret_key_base: "supersecretkey",
  pubsub_server: Chat.PubSub,
  live_view: [signing_salt: "secret"]
