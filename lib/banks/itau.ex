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

  @spec is_valid([Integer.t()], Integer.t(), Integer.t() | String.t()) ::
          {:error, :invalid_account_number_length | :invalid_agency_code_length | :not_valid}
          | {:ok, :valid}
  def is_valid(agency_code, account_number, digit) do
    with {:ok, :valid} <- is_valid_agency_code(agency_code),
         {:ok, :valid} <- is_valid_account_number(account_number),
         {:ok, parsed_digit} <- is_valid_numeric_digit?(digit) do
      digit_result =
        (agency_code ++ account_number)
        |> DigitCalculator.mod(10, @weigths, true)
        |> rem(10)

      if digit_result == parsed_digit do
        {:ok, :valid}
      else
        {:error, :not_valid}
      end
    else
      result -> result
    end
  end

  defp is_valid_account_number(account_number) do
    if length(account_number) == 5 do
      {:ok, :valid}
    else
      {:error, :invalid_account_number_length}
    end
  end
end
