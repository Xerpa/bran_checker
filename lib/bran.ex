defmodule BRAN do
  alias BRAN.Banks.Itau
  alias BRAN.Banks.Santander

  @moduledoc """
  Documentation for `BRAN`.
  """

  @doc """
  validate
  Returns a boolean, after checking if the combination of bank_code, agency_number, account_number and digit is valid

  ## Examples
    iex> BRAN.is_valid?("341","2545", "02366", 1)
    :true
  """
  @spec validate(String.t(), String.t(), String.t(), String.t() | Integer.t()) ::
          {:error,
           :invalid_account_number_length
           | :invalid_account_type
           | :invalid_agency_code_length
           | :not_supported
           | :not_valid}
          | {:ok, :valid}
  def validate(bank_code, agency_code, account_number, digit) do
    parsed_agency_code = parse_to_integer_list(agency_code)

    parsed_account_number = parse_to_integer_list(account_number)

    case bank_code do
      "033" ->
        Santander.validate(parsed_agency_code, parsed_account_number, digit)

      "341" ->
        Itau.validate(parsed_agency_code, parsed_account_number, digit)

      _ ->
        {:error, :not_supported}
    end
  end

  @spec validate(binary, binary, binary) ::
          {:error,
           :invalid_account_number_length
           | :invalid_account_type
           | :invalid_agency_code_length
           | :not_supported
           | :not_valid}
          | {:ok, :valid}
  def validate(bank_code, agency_code, account_with_digit) do
    {account, digit} = split_account_and_digit(account_with_digit)

    validate(bank_code, agency_code, account, digit)
  end

  defp split_account_and_digit(account_with_digit) do
    {account, digit} =
      account_with_digit
      |> String.replace("-", "")
      |> String.split_at(-1)

    {account, digit}
  end

  defp parse_to_integer_list(numbers) do
    numbers
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end
end
