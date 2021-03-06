alias Polcom.{Flight, Metadata, CreditCardOperatingCostResolver}
alias Core.{Profiler, Result}

defmodule Polcom.FlightController do
  use Polcom.Web, :controller
  import Core.Phoenix.JSONResponseUtil
  require Logger

  def find(conn, params), do: response(conn, find_from(params))

  defp response(conn, %Result{return: return}) when return == [],
    do: send_error_resp(conn, 400, "not found")
  defp response(conn, %Result{} = result) do
    Logger.debug("...process time: #{result.time}")
    send_resp(conn, 200, Poison.encode!(result.return))
  end

  defp find_from(params) do
    Profiler.time(fn->
      CreditCardOperatingCostResolver.find(flight: flight(params), metadata: metadata(params))
    end)
  end

  defp flight(params) do
    Flight.create(
      airlines: String.split(params["airlines"], ","),
      origin: params["origin"],
      destination: params["destination"],
      departure: params["departureDate"],
      returning: params["returningDate"]
    )
  end

  defp metadata(params), do: Metadata.create(site: params["site"], brand: params["brand"], channel: params["channel"])
end
