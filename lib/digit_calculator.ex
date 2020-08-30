defmodule BankValidatorBR.DigitCalculator do
  defp calc_numbers(account_number, weights, sum_result_when_greater_than_9) do
    account_number
    |> Enum.zip(weights)
    |> Enum.map(&calc_number(&1, sum_result_when_greater_than_9))
    |> Enum.sum()
  end

  defp calc_number(numbers, sum_result_when_greater_than_9) do
    result = elem(numbers, 0) * elem(numbers, 1)

    sum_result(result, sum_result_when_greater_than_9)
  end

  defp sum_result(result, sum_result_when_greater_than_9) when sum_result_when_greater_than_9 do
    result
    |> Integer.digits()
    |> Enum.sum()
  end

  defp sum_result(result, _sum_result_when_greater_than_9), do: result

  def mod(full_account_number, mod_factor, weights, sum_result_when_greater_than_9 \\ false),
    do:
      mod_factor -
        rem(
          calc_numbers(full_account_number, weights, sum_result_when_greater_than_9),
          mod_factor
        )
end
