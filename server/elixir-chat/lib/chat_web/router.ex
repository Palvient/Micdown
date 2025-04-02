scope "/", ChatWeb do
  pipe_through :browser

  get "/", PageController, :index
end

socket "/socket", ChatWeb.UserSocket,
  websocket: true,
  longpoll: false
