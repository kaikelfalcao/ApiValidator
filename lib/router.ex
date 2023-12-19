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

  get "/cpf/:cpf" do
    cpf = to_string(cpf)
    cpf = Cpf.limpa_cpf(cpf)

    cond do
      not Cpf.tamanho_valido?(cpf) ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{status: "Invalido", motivo: "Tamanho Invalido"}))

      not Cpf.validar_cpf(cpf) ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          400,
          Jason.encode!(%{status: "Invalido", motivo: "Cpf não segue as regras de autenticação"})
        )

      true ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Jason.encode!(%{status: "Valido", motivo: "Cpf segue as regras de autenticação"})
        )
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
