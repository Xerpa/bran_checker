defmodule BRAN.Banks.Nubank do
  import BRAN.Banks.Util

  @moduledoc """
    Documentation `BRAN.Banks.Nubank`
  """

  @doc """
  Returns a tuple, after checking if the combination of branch_number, account_number and digit is valid

  ##Examples
    iex> BRAN.Banks.Nubank.validate([0,0,0,1], [5,2,1,6,1,2,5], 0)
    {:ok, :valid}
  """

  @spec validate([integer()], [integer()], integer() | String.t()) ::
          {:error, :invalid_account_number_length | :invalid_bank_branch_length | :not_valid}
          | {:ok, :valid}
  def validate(bank_branch, account_number, digit) do
    with true <- Enum.all?(account_number, &validate_numeric_digit?/1) || {:error, :not_valid},
         {:ok, parsed_account_number} <- validate_account_number(account_number),
         {:ok, :valid} <- validate_branch(bank_branch),
         {:ok, parsed_digit} <- validate_numeric_digit?(digit) do
      account_with_digit = String.to_integer("#{parsed_account_number}#{parsed_digit}")

      parsed_account_number
      |> :verhoeff.encode()
      |> case do
        ^account_with_digit ->
          {:ok, :valid}

        _ ->
          {:error, :not_valid}
      end
    end
  end

  defp validate_account_number(account_number) do
    account_number
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> validate_numeric_digit?()
  end

  defp validate_branch(bank_branch) do
    bank_branch
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> validate_branch_by_example()
  end
end
