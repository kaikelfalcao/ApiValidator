defmodule Cpf do
  @moduledoc """
  Modulo de validação para CPF
  """

  @spec tamanho_valido?(String.t()) :: boolean()
  def tamanho_valido?(cpf) do
    Regex.match?(~r/\d{11}$/, cpf)
  end

  @spec limpa_cpf(String.t()) :: String.t()
  def limpa_cpf(cpf) do
    Regex.replace(~r/\D+/, cpf, "")
  end

  defp calcular_soma([], _multiplicador, acc), do: acc

  defp calcular_soma([digito | restante], multiplicador, acc) do
    valor = String.to_integer(digito) * multiplicador
    novo_multiplicador = multiplicador - 1
    calcular_soma(restante, novo_multiplicador, acc + valor)
  end

  def calcular_primeiro_digito(cpf) do
    cpf = String.slice(cpf, 0, 9)
    lista_de_numeros = String.graphemes(cpf)
    soma = calcular_soma(lista_de_numeros, 10, 0)
    resto = rem(soma, 11)

    cond do
      resto < 2 -> 0
      resto == 10 -> 0
      true -> 11 - resto
    end
  end

  def calcular_segundo_digito(cpf) do
    cpf = String.slice(cpf, 0, 9)
    cpf = cpf <> Integer.to_string(calcular_primeiro_digito(cpf))
    lista_de_numeros = String.graphemes(cpf)
    soma = calcular_soma(lista_de_numeros, 11, 0)
    resto = rem(soma, 11)

    cond do
      resto < 2 -> 0
      resto == 10 -> 0
      true -> 11 - resto
    end
  end

  def validar_cpf(cpf) do
    cpf = limpa_cpf(cpf)

    if tamanho_valido?(cpf) do
      digitos = String.slice(cpf, 9, 11)

      digitos_calculados =
        Integer.to_string(calcular_primeiro_digito(cpf)) <>
          Integer.to_string(calcular_segundo_digito(cpf))

      digitos == digitos_calculados
    else
      false
    end
  end
end
