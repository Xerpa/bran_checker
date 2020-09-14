defmodule BankValidatorBRTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  describe "is_valid/3" do
    test_with_params "returns {:ok, :valid} for valid accounts and digits with hyphen",
                     fn bank_code, agency, account ->
                       assert BankValidatorBR.is_valid(bank_code, agency, account) ==
                                {:ok, :valid}
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

    test_with_params "returns {:ok, :valid} for valid accounts and digits with no hyphen",
                     fn bank_code, agency, account ->
                       assert BankValidatorBR.is_valid(bank_code, agency, account) ==
                                {:ok, :valid}
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
  end

  describe "is_valid/4" do
    test_with_params "returns {:ok, :valid} when account is valid",
                     fn bank_code, agency, account, digit ->
                       assert BankValidatorBR.is_valid(bank_code, agency, account, digit) ==
                                {:ok, :valid}
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

    test_with_params "returns {:error, :not_valid} when account isn't valid",
                     fn bank_code, agency, account, digit ->
                       assert BankValidatorBR.is_valid(bank_code, agency, account, digit) ==
                                {:error, :not_valid}
                     end do
      [
        {"341", "7066", "62266", 2},
        {"341", "0658", "71228", 1},
        {"033", "0238", "37361952", 7},
        {"033", "4774", "13702705", 5}
      ]
    end
  end
end
