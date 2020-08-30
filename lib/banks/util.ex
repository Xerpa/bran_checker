defmodule BankValidatorBR.Banks.Util do
  def is_valid_agency_number?(agency_number), do: length(agency_number) == 4
end
