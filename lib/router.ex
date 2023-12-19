defmodule ApiValidator.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    data = %{message: "Ok"}
    json_data = Jason.encode!(data)

    send_resp(conn, 200, json_data)

  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
