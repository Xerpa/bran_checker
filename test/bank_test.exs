defmodule BRANTest do
  use ExUnit.Case
  use ExUnit.Parameterized

  describe "validate/3" do
    test_with_params "returns {:ok, :valid} for valid accounts and digits with hyphen",
                     fn bank_code, agency, account ->
                       assert BRAN.validate(bank_code, agency, account) == {:ok, :valid}
                     end do
      [
        {"341", "7062", "14945-0"},
        {"341", "7066", "62266-8"},
        {"341", "0658", "71228-6"},
        {"033", "0996", "09818292-5"},
        {"033", "0238", "37361952-9"},
        {"033", "4774", "13702705-3"},
        {"336", "0001", "2352605-0"},
        {"336", "0001", "2386564-4"},
        {"336", "0001", "2463803-0"},
        {"260", "0001", "5216125-0"},
        {"260", "0001", "1699629-9"},
        {"260", "0001", "3894066-5"},
        {"260", "0001", "96805203-6"}
      ]
    end

    test_with_params "returns {:ok, :valid} for valid accounts and digits with no hyphen",
                     fn bank_code, agency, account ->
                       assert BRAN.validate(bank_code, agency, account) == {:ok, :valid}
                     end do
      [
        {"341", "7062", "149450"},
        {"341", "7066", "622668"},
        {"341", "0658", "712286"},
        {"033", "0996", "098182925"},
        {"033", "0238", "373619529"},
        {"033", "4774", "137027053"},
        {"336", "0001", "23526050"},
        {"336", "0001", "23865644"},
        {"336", "0001", "24638030"},
        {"260", "0001", "52161250"},
        {"260", "0001", "16996299"},
        {"260", "0001", "38940665"},
        {"260", "0001", "968052036"}
      ]
    end
  end

  describe "validate/4" do
    test_with_params "returns {:ok, :valid} when account is valid",
                     fn bank_code, agency, account, digit ->
                       assert BRAN.validate(bank_code, agency, account, digit) == {:ok, :valid}
                     end do
      [
        {"341", "7062", "14945", 0},
        {"341", "7066", "62266", 8},
        {"341", "0658", "71228", 6},
        {"033", "0996", "09818292", 5},
        {"033", "0238", "37361952", 9},
        {"033", "4774", "13702705", 3},
        {"336", "0001", "2352605", 0},
        {"336", "0001", "2386564", 4},
        {"336", "0001", "2463803", 0},
        {"260", "0001", "5216125", 0},
        {"260", "0001", "1699629", 9},
        {"260", "0001", "3894066", 5},
        {"260", "0001", "96805203", 6}
      ]
    end

    test_with_params "returns {:error, :not_valid} when account isn't valid",
                     fn bank_code, agency, account, digit ->
                       assert BRAN.validate(bank_code, agency, account, digit) ==
                                {:error, :not_valid}
                     end do
      [
        {"341", "7066", "62266", 2},
        {"341", "0658", "71228", 1},
        {"033", "0238", "37361952", 7},
        {"033", "4774", "13702705", 5},
        {"336", "0001", "2352605", 5},
        {"336", "0001", "2386564", 1},
        {"336", "0001", "2463803", 9},
        {"260", "0001", "5216125", 6},
        {"260", "0001", "1699629", 3},
        {"260", "0001", "3894066", 1},
        {"260", "0001", "96805203", 0}
      ]
    end
  end
end
