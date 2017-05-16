alias Polcom.{PolcomRepo, ProductTypeMatcher, ItemMatcher, PaymentTypeMatcher, MetadataMatcher,
              AirlinesMatcher, RouteOriginMatcher, RouteDestinationMatcher, PeriodMatcher}

defmodule Polcom.FlightPolicySearcher do
  import Logger

  def find(flight, metadata, payment_type: payment_type, item_type: item_type) do
    policies = PolcomRepo.find_by(build_criterion(flight, payment_type, item_type, metadata))
    debug("...found #{Enum.count(policies)} policies.")
    policies
  end

  defp build_criterion(flight, payment_type, item_type, metadata) do
    fn policy ->
      ProductTypeMatcher.match?(flight.type, policy)
      and ItemMatcher.match?(item_type, policy)
      and PaymentTypeMatcher.match?(payment_type, policy)
      and MetadataMatcher.match?(metadata, policy)
      and AirlinesMatcher.match?(flight.airlines, policy)
      and RouteOriginMatcher.match?(flight.origin, policy)
      and RouteDestinationMatcher.match?(flight.destination, policy)
      and PeriodMatcher.match?(flight.departure, flight.returning, policy)
    end
  end
end
