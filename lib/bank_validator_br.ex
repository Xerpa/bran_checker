defmodule BankValidatorBR do
  alias BankValidatorBR.Itau

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
  def is_valid?(bank_code, agency_code, account_number, digit) do
    parsed_agency_code =
      agency_code
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)

    parsed_account_number =
      account_number
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)

    case bank_code do
      "341" ->
        Itau.is_valid?(parsed_agency_code, parsed_account_number, digit)

      _ ->
        raise "Bank #{bank_code} is not supported"
    end
  end
end
