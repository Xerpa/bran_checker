defmodule BRAN do
  alias BRAN.Banks.C6
  alias BRAN.Banks.Itau
  alias BRAN.Banks.Nubank
  alias BRAN.Banks.Santander

  @moduledoc """
  Documentation for `BRAN`.
  """

  @doc """
  validate
  Returns a tuple with {:ok, :valid} or {:error, :reason}, after checking if the combination of bank_code, branch_number, account_number and digit is valid

  ## Examples
    iex> BRAN.validate("341","2545", "02366", 1)
    {:ok, :valid}
  """
  @spec validate(String.t(), String.t(), String.t(), String.t() | integer()) ::
          {:error,
           :invalid_account_number_length
           | :invalid_account_type
           | :invalid_bank_branch_length
           | :not_supported
           | :not_valid}
          | {:ok, :valid}
  def validate(bank_code, bank_branch, account_number, digit) do
    parsed_bank_branch = parse_to_integer_list(bank_branch)

    parsed_account_number = parse_to_integer_list(account_number)

    case bank_code do
      "033" ->
        Santander.validate(parsed_bank_branch, parsed_account_number, digit)

      "341" ->
        Itau.validate(parsed_bank_branch, parsed_account_number, digit)

      "336" ->
        C6.validate(parsed_bank_branch, parsed_account_number, digit)

      "260" ->
        Nubank.validate(parsed_bank_branch, parsed_account_number, digit)

      _ ->
        {:error, :not_supported}
    end
  end

  @spec validate(binary, binary, binary) ::
          {:error,
           :invalid_account_number_length
           | :invalid_account_type
           | :invalid_bank_branch_length
           | :not_supported
           | :not_valid}
          | {:ok, :valid}
  def validate(bank_code, bank_branch, account_with_digit) do
    {account, digit} = split_account_and_digit(account_with_digit)

    validate(bank_code, bank_branch, account, digit)
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
