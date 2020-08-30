defmodule BankValidatorBR.ItauTest do
  alias BankValidatorBR.Itau

  use ExUnit.Case

  describe "BankValidatorBR.ItauTest" do
    test("should return true when the account is valid") do
      assert Itau.is_valid?([2, 5, 4, 5], [0, 2, 3, 6, 6], 1) == true
    end

    test("should return false when the account is invalid") do
      assert Itau.is_valid?([2, 5, 4, 5], [0, 2, 3, 6, 5], 1) == false
    end

    test("should return false when the agency number have less than 4 digits") do
      assert Itau.is_valid?([2, 5, 4], [0, 2, 3, 6, 6], 1) == false
    end

    test("should return false when the agency number have more than 4 digits") do
      assert Itau.is_valid?([2, 5, 4, 5, 5], [0, 2, 3, 6, 6], 1) == false
    end

    test("should return false when the account number have less than 5 digits") do
      assert Itau.is_valid?([2, 5, 4], [0, 2, 3, 6], 1) == false
    end

    test("should return false when the account number have more than 6 digits") do
      assert Itau.is_valid?([2, 5, 4, 5], [0, 2, 3, 6, 6, 6], 1) == false
    end
  end
end
