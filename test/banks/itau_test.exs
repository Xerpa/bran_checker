defmodule BankValidatorBR.Banks.ItauTest do
  alias BankValidatorBR.Banks.Itau

  use ExUnit.Case
  use ExUnit.Parameterized

  describe "BankValidatorBR.Banks.ItauTest" do
    test_with_params "should return valid tuple when the account is valid",
                     fn agency, account, digit ->
                       assert Itau.validate(agency, account, digit) == {:ok, :valid}
                     end do
      [
        {[4, 3, 1, 3], [4, 3, 1, 2, 9], 0},
        {[7, 0, 6, 8], [6, 0, 5, 2, 8], 1},
        {[4, 3, 0, 7], [9, 0, 1, 3, 3], 2},
        {[4, 2, 5, 8], [5, 8, 7, 8, 3], 3},
        {[1, 6, 6, 1], [3, 3, 9, 1, 7], 4},
        {[4, 2, 7, 5], [7, 4, 5, 8, 8], 5},
        {[6, 2, 5, 4], [6, 5, 4, 0, 4], 6},
        {[7, 9, 2, 8], [2, 3, 8, 4, 9], 7},
        {[1, 3, 8, 2], [2, 5, 2, 0, 7], 8},
        {[8, 5, 4, 9], [7, 4, 0, 1, 1], 9},
        {[4, 3, 1, 3], [4, 3, 1, 2, 9], "0"},
        {[7, 0, 6, 8], [6, 0, 5, 2, 8], "1"},
        {[4, 3, 0, 7], [9, 0, 1, 3, 3], "2"},
        {[4, 2, 5, 8], [5, 8, 7, 8, 3], "3"},
        {[1, 6, 6, 1], [3, 3, 9, 1, 7], "4"},
        {[4, 2, 7, 5], [7, 4, 5, 8, 8], "5"},
        {[6, 2, 5, 4], [6, 5, 4, 0, 4], "6"},
        {[7, 9, 2, 8], [2, 3, 8, 4, 9], "7"},
        {[1, 3, 8, 2], [2, 5, 2, 0, 7], "8"},
        {[8, 5, 4, 9], [7, 4, 0, 1, 1], "9"}
      ]
    end

    test_with_params "should return not_valid tuple when the account is valid",
                     fn agency, account, digit ->
                       assert Itau.validate(agency, account, digit) == {:error, :not_valid}
                     end do
      [
        {[4, 3, 1, 3], [4, 3, 1, 2, 9], 9},
        {[7, 0, 6, 8], [6, 0, 5, 2, 8], 8},
        {[4, 3, 0, 7], [9, 0, 1, 3, 3], 7},
        {[4, 2, 5, 8], [5, 8, 7, 8, 3], 6},
        {[1, 6, 6, 1], [3, 3, 9, 1, 7], 5},
        {[4, 2, 7, 5], [7, 4, 5, 8, 8], 4},
        {[6, 2, 5, 4], [6, 5, 4, 0, 4], 3},
        {[7, 9, 2, 8], [2, 3, 8, 4, 9], 2},
        {[1, 3, 8, 2], [2, 5, 2, 0, 7], 1},
        {[8, 5, 4, 9], [7, 4, 0, 1, 1], 0},
        {[4, 3, 1, 3], [4, 3, 1, 2, 9], "9"},
        {[7, 0, 6, 8], [6, 0, 5, 2, 8], "8"},
        {[4, 3, 0, 7], [9, 0, 1, 3, 3], "7"},
        {[4, 2, 5, 8], [5, 8, 7, 8, 3], "6"},
        {[1, 6, 6, 1], [3, 3, 9, 1, 7], "5"},
        {[4, 2, 7, 5], [7, 4, 5, 8, 8], "4"},
        {[6, 2, 5, 4], [6, 5, 4, 0, 4], "3"},
        {[7, 9, 2, 8], [2, 3, 8, 4, 9], "2"},
        {[1, 3, 8, 2], [2, 5, 2, 0, 7], "1"},
        {[8, 5, 4, 9], [7, 4, 0, 1, 1], "0"}
      ]
    end

    test(
      "should return invalid_agency_code_length tuple when the agency number have less than 4 digits"
    ) do
      assert Itau.validate([2, 5, 4], [0, 2, 3, 6, 6], 1) == {:error, :invalid_agency_code_length}
    end

    test(
      "should return invalid_agency_code_length tuple when the agency number have more than 4 digits"
    ) do
      assert Itau.validate([2, 5, 4, 5, 5], [0, 2, 3, 6, 6], 1) ==
               {:error, :invalid_agency_code_length}
    end

    test(
      "should return invalid_account_number_length tuple when the account number have less than 5 digits"
    ) do
      assert Itau.validate([2, 2, 5, 4], [0, 2, 3, 6], 1) ==
               {:error, :invalid_account_number_length}
    end

    test(
      "should return invalid_account_number_length tuple when the account number have more than 5 digits"
    ) do
      assert Itau.validate([2, 5, 4, 5], [0, 2, 3, 6, 6, 6], 1) ==
               {:error, :invalid_account_number_length}
    end

    test("should return {:not_valid, :non_numeric_digit} when the digit is a character") do
      assert Itau.validate([8, 5, 4, 9], [7, 4, 0, 1, 1], "P") == {:not_valid, :non_numeric_digit}
    end
  end
end
