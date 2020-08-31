defmodule BankValidatorBR.Banks.Util do
  @moduledoc """
  Documentation for `BankValidatorBR.Banks.Util`.
  """
  def is_valid_agency_number?(agency_number), do: length(agency_number) == 4
end
