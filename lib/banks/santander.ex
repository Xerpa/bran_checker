defmodule BankValidatorBR.Banks.Santander do
  alias BankValidatorBR.DigitCalculator

  import BankValidatorBR.Banks.Util

  @moduledoc """
    Documentation `BankValidatorBR.Banks.Santander`
  """

  @weigths [9, 7, 3, 1, 0, 0, 9, 7, 1, 3, 1, 9, 7, 3]
  @account_types [
    "01",
    "02",
    "03",
    "05",
    "07",
    "09",
    "13",
    "27",
    "35",
    "37",
    "43",
    "45",
    "46",
    "48",
    "50",
    "53",
    "60",
    "92"
  ]

  @doc """
  Returns a boolean, after checking if the combination of agency_number, account_number and digit is valid

  ##Examples
    iex> BankValidatorBR.Santander.is_valid?([2,5,4,5], [0,2,3,6,6,0,2,3], 1)
    :true
  """
  @spec is_valid?(List.t(), List.t(), Integer.t()) :: Boolean.t()
  def is_valid?(agency_number, account_number, digit) do
    with true <- is_valid_agency_number?(agency_number),
         true <- is_valid_account_number?(account_number),
         true <- is_valid_account_type?(account_number) do
      full_account_number = agency_number ++ [0, 0] ++ account_number

      digit_result =
        full_account_number
        |> DigitCalculator.calc_numbers(@weigths, false)
        |> rem(10)

      digit_result == digit
    else
      _ -> false
    end
  end

  defp is_valid_account_number?(account_number), do: length(account_number) == 8

  defp is_valid_account_type?(account_number) do
    account_type =
      account_number
      |> Enum.take(2)
      |> Enum.join()

    Enum.member?(@account_types, account_type)
  end
end
