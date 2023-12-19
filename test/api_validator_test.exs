defmodule ApiValidatorTest do
  use ExUnit.Case, async: true

  use Plug.Test

  @opts ApiValidator.Router.init([])

  test "return ok" do
    conn = conn(:get, "/")

    conn = ApiValidator.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert Jason.decode!(conn.resp_body) == %{"message" => "Ok"}
  end

  test "return status e messagem de um cpf valido" do
    conn = conn(:get, "/cpf/12345678909")

    conn = ApiValidator.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert Jason.decode!(conn.resp_body) == %{
             "status" => "Valido",
             "motivo" => "Cpf segue as regras de autenticação"
           }
  end

  test "return status e messagem de um cpf invalido" do
    conn = conn(:get, "/cpf/12345678900")

    conn = ApiValidator.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 400

    assert Jason.decode!(conn.resp_body) == %{
             "status" => "Invalido",
             "motivo" => "Cpf não segue as regras de autenticação"
           }
  end

  test "return status e messagem de um cpf invalido de tamanho" do
    conn = conn(:get, "/cpf/1234567890")

    conn = ApiValidator.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 400

    assert Jason.decode!(conn.resp_body) == %{
             "status" => "Invalido",
             "motivo" => "Tamanho Invalido"
           }
  end
end
