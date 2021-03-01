defmodule BRAN.DigitCalculatorTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  alias BRAN.DigitCalculator

  @itau_weight [2, 1, 2, 1, 2, 1, 2, 1, 2]
  @itau_mod_factor 10

  test_with_params "returns mod to consider on Itau validation",
                   fn account_number, mod_factor, weights, sum_result, expected ->
                     assert DigitCalculator.mod(
                              account_number,
                              mod_factor,
                              weights,
                              sum_result
                            ) == expected
                   end do
    [
      # Valid Accounts
      {[4, 3, 1, 3, 4, 3, 1, 2, 9, 0], @itau_mod_factor, @itau_weight, true, 10},
      {
        [7, 0, 6, 8, 6, 0, 5, 2, 8, 8],
        @itau_mod_factor,
        @itau_weight,
        true,
        1
      },
      {[4, 3, 1, 3, 4, 3, 1, 2, 9, 0], @itau_mod_factor, @itau_weight, false, 1}
    ]
  end
end
