alias Polcom.{FlightPolicySearcher, PolicyToCreditCardOperatingfCostConverter}

defmodule Polcom.CreditCardOperatingCostResolver do
  import Logger

  def find(flight: flight, metadata: metadata) do
    policies = FlightPolicySearcher.find(flight, metadata, payment_type: "CREDIT_CARD", item_type: "FARE")

    result = PolicyToCreditCardOperatingfCostConverter.convert(policies, flight)
    debug("...generated #{Enum.count(result)} credit card operating costs.")
    result
  end
end
