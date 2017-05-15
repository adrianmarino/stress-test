alias Polcom.{PolcomRepo, ProductTypeMatcher, ItemMatcher, PaymentTypeMatcher, MetadataMatcher}
alias Polcom.{AirlineMatcher, RouteOriginMatcher, RouteDestinationMatcher, PeriodMatcher}

defmodule Polcom.FlightPolicySearcher do
  import Logger

  def find(flight, payment_type, metadata) do
    policies = PolcomRepo.find_by(build_criterion(flight, payment_type, metadata))
    debug("...found #{Enum.count(policies)} policies.")
    policies
  end

  defp build_criterion(flight, payment_type, metadata) do
    fn policy ->
      ProductTypeMatcher.match?("FLIGHT", policy)
      and ItemMatcher.match?("FARE", policy)
      and PaymentTypeMatcher.match?(payment_type, policy)
      and MetadataMatcher.match?(metadata, policy)
      and AirlineMatcher.match?(flight.airline, policy)
      and RouteOriginMatcher.match?(flight.origin, policy)
      and RouteDestinationMatcher.match?(flight.destination, policy)
      and PeriodMatcher.match?(flight.departure, flight.returning, policy)
    end
  end
end
