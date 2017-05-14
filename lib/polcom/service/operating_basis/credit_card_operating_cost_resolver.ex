alias Polcom.Flight
alias Polcom.Metadata
alias Polcom.FlightPolicySearcher
alias Polcom.PolicyToCreditCardOperatinfCostConverter

defmodule Polcom.CreditCardOperatingCostResolver do

  def find_test_print, do: IO.puts(Core.JSON.to_pretty_json(find_test()))
  def find_test_profiler, do: Core.Profiler.time(fn-> find_test() end)
  def find_test_time, do: to_string(find_test_profiler())

  def find_test do
    find(
      flight: Flight.create(airline: "AR", origin: "EZE", destination: "MAD",
                            departure: "2016-11-16", returning: "2016-11-23"),
      metadata: Metadata.create(site: "ARG", brand: "ALMUNDO", channel: "WEB")
    )
  end

  def find(flight: flight, metadata: metadata) do
    policies = FlightPolicySearcher.find(flight, "CREDIT_CARD", metadata)

    result = PolicyToCreditCardOperatinfCostConverter.convert(policies, flight.airline)
    IO.puts("...generated #{Enum.count(result)} credit card operating costs.")
    result
  end
end
