alias Polcom.PolcomRepo
alias Polcom.Flight
alias Polcom.Metadata

defmodule Polcom.FlightOperatingCostService do
  def find_test_count, do: Enum.count(find_test())

  def find_test do
    find(
      Flight.create(
        airline: "AR",
        origin: "EZE",
        destination: "MAD",
        departure: "2016-11-16",
        returning: "2016-11-23"
      ),
      "CREDIT_CARD",
      Metadata.create(site: "ARG", brand: "ALMUNDO", channel: "WEB")
    )
  end

  def find(flight, payment_type, metadata) do
    PolcomRepo.find_by(fn policy ->
      Polcom.ProductTypeMatcher.match?("FLIGHT", policy)
      and Polcom.ItemMatcher.match?("FARE", policy)
      and Polcom.PaymentTypeMatcher.match?(payment_type, policy)
      and Polcom.MetadataMatcher.match?(metadata, policy)
      and Polcom.AirlineMatcher.match?(flight.airline, policy)
      and Polcom.RouteOriginMatcher.match?(flight.origin, policy)
      and Polcom.RouteDestinationMatcher.match?(flight.destination, policy)
      and Polcom.PeriodMatcher.match?(flight.departure, flight.returning, policy)
    end)
  end
end
