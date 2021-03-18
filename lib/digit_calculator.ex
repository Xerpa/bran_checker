defmodule BRAN.DigitCalculator do
  @moduledoc """
  Documentation for `BRAN.DigitCalculator`.
  """
  @spec mod([Integer.t()], Integer.t(), [Integer.t()], Function.t()) :: Integer.t()
  def mod(full_account_number, mod_factor, weights, sum_digits \\ fn stream -> stream end) do
    full_account_number
    |> calc_numbers(weights, sum_digits)
    |> rem(mod_factor)
    |> (&(mod_factor - &1)).()
    |> rem(mod_factor)
  end

  @spec mod_simple([Integer.t()], Integer.t(), [Integer.t()], Function.t()) :: Integer.t()
  def mod_simple(full_account_number, mod_factor, weights, sum_digits \\ fn stream -> stream end) do
    full_account_number
    |> calc_numbers(weights, sum_digits)
    |> rem(mod_factor)
  end

  @spec calc_numbers([Integer.t()], [Integer.t()], Function.t()) :: Integer.t()
  defp calc_numbers(account_number, weights, sum_digits) do
    cycle = Stream.cycle(weights)

    account_number
    |> Stream.zip(cycle)
    |> Stream.map(fn {elem0, elem1} -> elem0 * elem1 end)
    |> sum_digits.()
    |> Enum.sum()
  end
end
