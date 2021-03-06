defmodule BRAN.Banks.C6 do
  alias BRAN.DigitCalculator

  import BRAN.Banks.Util

  @moduledoc """
    Documentation `BRAN.Banks.C6`
  """

  @account_number_size 7

  @weigths [8, 7, 6, 5, 4, 3, 2]

  @doc """
  Returns a tuple, after checking if the account_number and digit is valid

  ##Examples
    iex> BRAN.Banks.C6.validate([0,0,0,1], [1,7,9,2,7,0,6], 4)
    {:ok, :valid}
  """

  @spec validate([integer()], [integer()], integer() | String.t()) ::
          {:error, :not_valid} | {:ok, :valid}
  def validate(bank_branch, account_number, digit) do
    bank_branch_string =
      bank_branch
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()

    with true <- Enum.all?(account_number, &validate_numeric_digit?/1) || {:error, :not_valid},
         {:ok, :valid} <- validate_branch_by_example(bank_branch_string),
         {:ok, parsed_digit} <- validate_numeric_digit?(digit) do
      account_number
      |> fill_with_zeros()
      |> DigitCalculator.mod_simple(11, @weigths)
      |> digit()
      |> case do
        ^parsed_digit ->
          {:ok, :valid}

        _ ->
          {:error, :not_valid}
      end
    end
  end

  defp fill_with_zeros(account_number) do
    account_number
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> String.pad_leading(@account_number_size, "0")
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  defp digit(mod) when mod <= 1, do: 0
  defp digit(mod), do: abs(11 - mod)
end
