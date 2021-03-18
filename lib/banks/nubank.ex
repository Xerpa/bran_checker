defmodule BRAN.Banks.Nubank do
  import BRAN.Banks.Util

  @moduledoc """
    Documentation `BRAN.Banks.Nubank`
  """

  @doc """
  Returns a tuple, after checking if the combination of agency_number, account_number and digit is valid

  ##Examples
    iex> BRAN.Banks.Nubank.validate([0,0,0,1], [5,2,1,6,1,2,5], 0)
    :true
  """

  @spec validate([Integer.t()], [Integer.t()], Integer.t() | String.t()) ::
          {:error, :invalid_account_number_length | :invalid_agency_code_length | :not_valid}
          | {:ok, :valid}
  def validate(agency_code, account_number, digit) do
    agency_code_string =
      agency_code
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()

    account_number_string =
      account_number
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()

    with true <- Enum.all?(account_number, &validate_numeric_digit?/1) || {:error, :not_valid},
         {:ok, parsed_account_number} <- validate_numeric_digit?(account_number_string),
         {:ok, :valid} <- validate_agency_by_example(agency_code_string),
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
end
