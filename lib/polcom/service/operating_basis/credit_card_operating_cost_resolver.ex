alias Polcom.FlightPolicySearcher
alias Polcom.PolicyToCreditCardOperatinfCostConverter

defmodule Polcom.CreditCardOperatingCostResolver do
  import Logger

  def find(flight: flight, metadata: metadata) do
    policies = FlightPolicySearcher.find(flight, "CREDIT_CARD", metadata)

    result = PolicyToCreditCardOperatinfCostConverter.convert(policies, flight.airline)
    debug("...generated #{Enum.count(result)} credit card operating costs.")
    result
  end
end
