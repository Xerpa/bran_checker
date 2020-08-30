defmodule BankValidatorBR.Itau do
  alias BankValidatorBR.DigitCalculator

  @moduledoc """
    Documentation `BankValidatorBR.Itau`
  """

  @weigths [2, 1, 2, 1, 2, 1, 2, 1, 2]

  @doc """
  Returns a boolean, after checking if the combination of agency_number, account_number and digit is valid

  ##Examples
    iex> BankValidatorBR.Itau.is_valid?([2,5,4,5], [0,2,3,6,6], 1)
    :true
  """
  @spec is_valid?(List.t(), List.t(), Integer.t()) :: Boolean.t()
  def is_valid?(agency_number, account_number, digit) do
    with true <- is_valid_agency_number?(agency_number),
         true <- is_valid_account_number?(account_number) do
      digit_result = DigitCalculator.mod(agency_number ++ account_number, 10, @weigths, true)

      IO.puts("digit: #{inspect(digit_result)}")
      digit_result === 10 || digit_result == digit
    else
      _ -> false
    end
  end

  defp is_valid_agency_number?(agency_number), do: length(agency_number) == 4
  defp is_valid_account_number?(account_number), do: length(account_number) == 5
end
