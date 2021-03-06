defmodule BRAN.Banks.Itau do
  alias BRAN.DigitCalculator

  import BRAN.Banks.Util

  @moduledoc """
    Documentation `BRAN.Banks.Itau`
  """

  @weigths [2, 1]

  @doc """
  Returns a tuple, after checking if the combination of branch_number, account_number and digit is valid

  ##Examples
    iex> BRAN.Banks.Itau.validate([2,5,4,5], [0,2,3,6,6], 1)
    {:ok, :valid}
  """

  @spec validate([integer()], [integer()], integer() | String.t()) ::
          {:error, :invalid_account_number_length | :invalid_bank_branch_length | :not_valid}
          | {:ok, :valid}
  def validate(bank_branch, account_number, digit) do
    with {:ok, :valid} <- validate_bank_branch(bank_branch),
         {:ok, :valid} <- validate_account_number(account_number),
         {:ok, parsed_digit} <- validate_numeric_digit?(digit) do
      (bank_branch ++ account_number)
      |> DigitCalculator.mod(10, @weigths, &sum_digits/1)
      |> case do
        ^parsed_digit ->
          {:ok, :valid}

        _ ->
          {:error, :not_valid}
      end
    end
  end

  defp validate_account_number(account_number) do
    if length(account_number) == 5 do
      {:ok, :valid}
    else
      {:error, :invalid_account_number_length}
    end
  end

  defp sum_digits(stream) do
    Stream.flat_map(stream, &Integer.digits/1)
  end
end
