defmodule BankValidatorBR.Banks.SantanderTest do
  alias BankValidatorBR.Banks.Santander

  use ExUnit.Case

  describe "BankValidatorBR.Banks.SantanderTest" do
    test("should return true when the account is valid") do
      assert Santander.is_valid?([0, 0, 6, 0], [0, 1, 0, 9, 8, 4, 8, 6], 0) == true
    end

    test("should return false when the account is invalid") do
      assert Santander.is_valid?([0, 0, 6, 0], [0, 2, 3, 6, 5], 1) == false
    end

    test("should return false when the agency number have less than 4 digits") do
      assert Santander.is_valid?([2, 5, 4], [0, 1, 0, 9, 8, 4, 8, 6], 1) == false
    end

    test("should return false when the agency number have more than 4 digits") do
      assert Santander.is_valid?([0, 0, 6, 0, 5], [0, 1, 0, 9, 8, 4, 8, 6], 1) == false
    end

    test("should return false when the account number have less than 5 digits") do
      assert Santander.is_valid?([2, 5, 4], [0, 2, 3, 6], 1) == false
    end

    test("should return false when the account number have more than 6 digits") do
      assert Santander.is_valid?([0, 0, 6, 0], [0, 1, 0, 9, 8, 4, 8, 6, 6], 0) == false
    end

    test("should return false when the account number starts with invalid operation") do
      assert Santander.is_valid?([0, 0, 6, 0], [9, 9, 0, 9, 8, 4, 8, 6], 0) == false
    end
  end
end
