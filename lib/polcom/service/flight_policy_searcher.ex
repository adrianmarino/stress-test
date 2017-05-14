alias Polcom.PolcomRepo

defmodule Polcom.FlightPolicySearcher do
  def find(flight, payment_type, metadata) do
    policies = PolcomRepo.find_by(build_criterion(flight, payment_type, metadata))
    IO.puts("...found #{Enum.count(policies)} policies.")
    policies
  end

  defp build_criterion(flight, payment_type, metadata) do
    fn policy ->
      Polcom.ProductTypeMatcher.match?("FLIGHT", policy)
      and Polcom.ItemMatcher.match?("FARE", policy)
      and Polcom.PaymentTypeMatcher.match?(payment_type, policy)
      and Polcom.MetadataMatcher.match?(metadata, policy)
      and Polcom.AirlineMatcher.match?(flight.airline, policy)
      and Polcom.RouteOriginMatcher.match?(flight.origin, policy)
      and Polcom.RouteDestinationMatcher.match?(flight.destination, policy)
      and Polcom.PeriodMatcher.match?(flight.departure, flight.returning, policy)
    end
  end
end
