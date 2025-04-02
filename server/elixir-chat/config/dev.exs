import Config

config :chat, ChatWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, level: :debug

config :chat, redis_url: "redis://redis:6379/0"
