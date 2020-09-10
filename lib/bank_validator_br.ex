defmodule BankValidatorBR do
  alias BankValidatorBR.Banks.Itau
  alias BankValidatorBR.Banks.Santander

  @moduledoc """
  Documentation for `BankValidatorBR`.
  """

  @doc """
  is_valid
  Returns a boolean, after checking if the combination of bank_code, agency_number, account_number and digit is valid

  ## Examples
    iex> BankValidatorBR.is_valid?("341","2545", "02366", 1)
    :true
  """

  @spec is_valid?(String.t(), String.t(), String.t(), Integer.t()) :: Boolean.t()
  def is_valid?(bank_code, agency_code, account_number, digit) when is_integer(digit) do
    parsed_agency_code = parse_to_integer_list(agency_code)

    parsed_account_number = parse_to_integer_list(account_number)

    case bank_code do
      "033" ->
        Santander.is_valid?(parsed_agency_code, parsed_account_number, digit)

      "341" ->
        Itau.is_valid?(parsed_agency_code, parsed_account_number, digit)

      _ ->
        raise "Bank #{bank_code} is not supported"
    end
  end

  def is_valid?(_bank_code, _agency_code, _account, _digit) do
    raise ArgumentError, message: "Invalid account number format"
  end

  def is_valid?(bank_code, agency_code, account_with_digit) do
    {account, digit} = split_account_and_digit(account_with_digit)

    is_valid?(bank_code, agency_code, account, digit)
  end

  defp split_account_and_digit(account_with_digit) do
    {account, digit} =
      account_with_digit
      |> String.replace("-", "")
      |> String.split_at(-1)

    case Integer.parse(digit) do
      {parsed_digit, _} ->
        {account, parsed_digit}

      :error ->
        raise ArgumentError, message: "Invalid account number format"
    end
  end

  defp parse_to_integer_list(numbers) do
    numbers
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end
end
