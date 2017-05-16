alias Polcom.{FlightPolicySearcher, PolicyToCreditCardOperatinfCostConverter}

defmodule Polcom.CreditCardOperatingCostResolver do
  import Logger

  def find(flight: flight, metadata: metadata) do
    policies = FlightPolicySearcher.find(flight, "CREDIT_CARD", metadata)

    result = PolicyToCreditCardOperatinfCostConverter.convert(policies)
    debug("...generated #{Enum.count(result)} credit card operating costs.")
    result
  end
end
