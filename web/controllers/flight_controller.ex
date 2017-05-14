alias Polcom.Flight
alias Polcom.Metadata
alias Polcom.CreditCardOperatingCostResolver
alias Core.Profiler

defmodule Polcom.FlightController do
  use Polcom.Web, :controller
  import Core.Phoenix.JSONResponseUtil

  def find(conn, _params) do
    flight = Flight.create( airline: "AR", origin: "EZE", destination: "MAD",
                            departure: "2016-11-16", returning: "2016-11-23")
    metadata = Metadata.create(site: "ARG", brand: "ALMUNDO", channel: "WEB")

    result =  Profiler.time(fn->
      CreditCardOperatingCostResolver.find(flight: flight, metadata: metadata)
    end)
    IO.puts("...process time: #{result.time}")

    case result.return do
      [] -> send_error_resp(conn, 400, "not found")
      return -> send_body_resp(conn, 200, return)
    end
  end
end
