defmodule ApiValidator.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: [~c"application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Ok")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
