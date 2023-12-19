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
end
