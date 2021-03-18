defmodule BRAN.Banks.Util do
  @moduledoc """
  Documentation for `BRAN.Banks.Util`.
  """
  @spec validate_bank_branch([integer()]) :: {:error, :invalid_bank_branch_length} | {:ok, :valid}
  def validate_bank_branch(bank_branch) do
    if length(bank_branch) == 4 do
      {:ok, :valid}
    else
      {:error, :invalid_bank_branch_length}
    end
  end

  @spec validate_branch_by_example(String.t(), String.t()) ::
          {:error, :invalid_bank_branch} | {:ok, :valid}
  def validate_branch_by_example(bank_branch, branch_example \\ "0001") do
    if bank_branch == branch_example do
      {:ok, :valid}
    else
      {:error, :invalid_bank_branch}
    end
  end

  @spec validate_numeric_digit?(String.t() | integer()) ::
          {:not_valid, :non_numeric_digit} | {:ok, integer}
  def validate_numeric_digit?(digit) when is_integer(digit), do: {:ok, digit}
  def validate_numeric_digit?(nil), do: {:not_valid, :non_numeric_digit}

  def validate_numeric_digit?(digit) do
    case Integer.parse(digit) do
      {parsed_digit, _rest} ->
        {:ok, parsed_digit}

      _ ->
        {:not_valid, :non_numeric_digit}
    end
  end
end
