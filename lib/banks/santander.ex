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
    iex> BankValidatorBR.Santander.is_valid([2,5,4,5], [0,2,3,6,6,0,2,3], 1)
    :true
  """
  @spec is_valid([Integer.t()], Integer.t(), Integer.t() | String.t()) ::
          {:error,
           :invalid_account_number_length
           | :invalid_account_type
           | :invalid_agency_code_length
           | :not_valid}
          | {:ok, :valid}
  def is_valid(agency_code, account_number, digit) do
    with {:ok, :valid} <- is_valid_agency_code(agency_code),
         {:ok, :valid} <- is_valid_account_number(account_number),
         {:ok, :valid} <- is_valid_account_type(account_number),
         {:ok, parsed_digit} <- is_valid_numeric_digit?(digit) do
      full_account_number = agency_code ++ [0, 0] ++ account_number

      validating_digit =
        full_account_number
        |> DigitCalculator.calc_numbers(@weigths, false)
        |> rem(10)
        |> calc_digit()

      if validating_digit == parsed_digit do
        {:ok, :valid}
      else
        {:error, :not_valid}
      end
    else
      result -> result
    end
  end

  defp is_valid_account_number(account_number) do
    if length(account_number) == 8 do
      {:ok, :valid}
    else
      {:error, :invalid_account_number_length}
    end
  end

  defp is_valid_account_type(account_number) do
    account_type =
      account_number
      |> Enum.take(2)
      |> Enum.join()

    if Enum.member?(@account_types, account_type) do
      {:ok, :valid}
    else
      {:error, :invalid_account_type}
    end
  end

  defp calc_digit(digit) when digit == 0, do: digit
  defp calc_digit(digit), do: 10 - digit
end
