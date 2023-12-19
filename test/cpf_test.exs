defmodule CpfTest do
  use ExUnit.Case

  test "tamanho_valido? retorna true para todos os CPFs com tamanho correto" do
    for cpf <- [
          "12345678900",
          "23456789010",
          "34567890120"
        ] do
      assert Cpf.tamanho_valido?(cpf)
    end
  end

  test "validar_cpf retorna true para todos os CPFs válidos" do
    for cpf <- [
          "12345678909",
          "13768663663"
        ] do
      assert Cpf.validar_cpf(cpf)
    end
  end

  test "calcular_primeiro_digito retorna true para o calculo correto" do
    assert Cpf.calcular_primeiro_digito("13768663663") == 6
  end

  test "calcular_primeiro_digito retorna false para o calculo errado" do
    refute Cpf.calcular_primeiro_digito("13768663663") == 5
  end

  test "calcular_segundo_digito retorna true para o calculo correto" do
    assert Cpf.calcular_segundo_digito("13768663663") == 3
  end

  test "calcular_segundo_digito retorna false para o calculo errado" do
    refute Cpf.calcular_segundo_digito("13768663663") == 0
  end
end
