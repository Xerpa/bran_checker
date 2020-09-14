defmodule BankValidatorBR.Banks.Itau do
  alias BankValidatorBR.DigitCalculator

  import BankValidatorBR.Banks.Util

  @moduledoc """
    Documentation `BankValidatorBR.Banks.Itau`
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
         true <- is_valid_account_number?(account_number),
         {:ok, parsed_digit} <- is_valid_numeric_digit?(digit) do
      digit_result =
        (agency_number ++ account_number)
        |> DigitCalculator.mod(10, @weigths, true)
        |> rem(10)

      digit_result == parsed_digit
    else
      _ -> false
    end
  end

  defp is_valid_account_number?(account_number), do: length(account_number) == 5
end
