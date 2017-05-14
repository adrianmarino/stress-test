alias Polcom.Flight
alias Polcom.Metadata
alias Polcom.CreditCardOperatingCostResolver

defmodule Polcom.FlightController do
  use Polcom.Web, :controller
  import Core.Phoenix.JSONResponseUtil

  def find(conn, _params) do
    flight = Flight.create( airline: "AR", origin: "EZE", destination: "MAD",
                            departure: "2016-11-16", returning: "2016-11-23")
    metadata = Metadata.create(site: "ARG", brand: "ALMUNDO", channel: "WEB")

    case CreditCardOperatingCostResolver.find(flight: flight, metadata: metadata) do
      [] -> send_error_resp(conn, 400, "not found")
      result -> send_body_resp(conn, 200, result)
    end
  end
end
