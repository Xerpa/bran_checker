defmodule BRAN.Banks.UtilTest do
  alias BRAN.Banks.Util

  use ExUnit.Case
  use ExUnit.Parameterized

  doctest BRAN.Banks.Util

  describe "validate_bank_branch/1" do
    test_with_params "should validate branch code properly", fn bank_branch, expected_result ->
      assert Util.validate_bank_branch(bank_branch) == expected_result
    end do
      [
        {[0, 0, 0, 1], {:ok, :valid}},
        {[1, 0, 0, 1], {:ok, :valid}},
        {[0, 0, 1], {:error, :invalid_bank_branch_length}}
      ]
    end
  end

  describe "validate_branch_by_example/2" do
    test_with_params "should validate branch code properly based on givn example",
                     fn bank_branch, example, expected_result ->
                       assert Util.validate_branch_by_example(bank_branch, example) ==
                                expected_result
                     end do
      [
        {"0001", "0001", {:ok, :valid}},
        {"0001", "0002", {:error, :invalid_bank_branch}},
        {"001", "0001", {:error, :invalid_bank_branch}}
      ]
    end
  end

  describe "validate_numeric_digit?/1" do
    test_with_params "should validate numeric digit properly", fn digits, expected_result ->
      assert Util.validate_numeric_digit?(digits) == expected_result
    end do
      [
        {"123456", {:ok, 123_456}},
        {123_456, {:ok, 123_456}},
        {"12E456", {:ok, 12}},
        {"ABCDE", {:not_valid, :non_numeric_digit}},
        {nil, {:not_valid, :non_numeric_digit}}
      ]
    end
  end
end
