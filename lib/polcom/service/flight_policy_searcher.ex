alias Polcom.PolcomRepo
alias Polcom.Flight
alias Polcom.Metadata

defmodule Polcom.FlightPolicySearcher do
  def find(flight, payment_type, metadata) do
    PolcomRepo.find_by(build_criterion(flight, payment_type, metadata))
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
