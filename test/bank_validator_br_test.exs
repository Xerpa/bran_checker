defmodule BankValidatorBRTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  describe "is_valid?/3" do
    test_with_params "returns true for valid accounts and digits with hyphen",
                     fn bank_code, agency, account ->
                       assert BankValidatorBR.is_valid?(bank_code, agency, account) == true
                     end do
      [
        {"341", "7062", "14945-0"},
        {"341", "7066", "62266-8"},
        {"341", "0658", "71228-6"},
        {"033", "0996", "09818292-5"},
        {"033", "0238", "37361952-9"},
        {"033", "4774", "13702705-3"}
      ]
    end

    test_with_params "returns true for valid accounts and digits with no hyphen",
                     fn bank_code, agency, account ->
                       assert BankValidatorBR.is_valid?(bank_code, agency, account) == true
                     end do
      [
        {"341", "7062", "149450"},
        {"341", "7066", "622668"},
        {"341", "0658", "712286"},
        {"033", "0996", "098182925"},
        {"033", "0238", "373619529"},
        {"033", "4774", "137027053"}
      ]
    end

    test_with_params "returns an error when digit is not a number",
                     fn bank_code, agency, account ->
                       assert_raise ArgumentError, "Invalid account number format", fn ->
                         BankValidatorBR.is_valid?(bank_code, agency, account)
                       end
                     end do
      [
        {"341", "7062", "14945X"},
        {"341", "7066", "62266-X"},
        {"033", "0996", "09818292X"},
        {"033", "0238", "37361952-X"}
      ]
    end
  end

  describe "is_valid?/4" do
    test_with_params "returns true when account is valid",
                     fn bank_code, agency, account, digit ->
                       assert BankValidatorBR.is_valid?(bank_code, agency, account, digit) == true
                     end do
      [
        {"341", "7062", "14945", 0},
        {"341", "7066", "62266", 8},
        {"341", "0658", "71228", 6},
        {"033", "0996", "09818292", 5},
        {"033", "0238", "37361952", 9},
        {"033", "4774", "13702705", 3}
      ]
    end

    test_with_params "returns false when account isn't valid",
                     fn bank_code, agency, account, digit ->
                       assert BankValidatorBR.is_valid?(bank_code, agency, account, digit) ==
                                false
                     end do
      [
        {"341", "7066", "62266", 2},
        {"341", "0658", "71228", 1},
        {"033", "0238", "37361952", 7},
        {"033", "4774", "13702705", 5}
      ]
    end

    test_with_params "raises an error for unimplemented bank validation",
                     fn bank_code, agency, account, digit ->
                       assert_raise RuntimeError, "Bank #{bank_code} is not supported", fn ->
                         BankValidatorBR.is_valid?(bank_code, agency, account, digit) == false
                       end
                     end do
      [
        {"123", "7066", "62266", 2},
        {"456", "4774", "13702705", 5}
      ]
    end
  end

  test_with_params "returns an error when digit is not a number",
                   fn bank_code, agency, account, digit ->
                     assert_raise ArgumentError, "Invalid account number format", fn ->
                       BankValidatorBR.is_valid?(bank_code, agency, account, digit)
                     end
                   end do
    [
      {"341", "7062", "14945", "X"},
      {"033", "0996", "09818292", "X"}
    ]
  end
end
