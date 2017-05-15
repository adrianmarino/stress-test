alias Polcom.{Flight, Metadata, CreditCardOperatingCostResolver}
alias Core.{Profiler, Result}

defmodule Polcom.FlightController do
  use Polcom.Web, :controller
  import Core.Phoenix.JSONResponseUtil

  def find(conn, params), do: response(conn, find_from(params))

  defp response(conn, %Result{return: return}) when return == [],
    do: send_error_resp(conn, 400, "not found")
  defp response(conn, %Result{} = result) do
    # IO.puts("...process time: #{result.time}")
    send_body_resp(conn, 200, result.return)
  end

  defp find_from(params), do: CreditCardOperatingCostResolver.find(flight: flight(params), metadata: metadata(params))

  defp flight(params) do
    Flight.create(
      airlines: String.split(params["airlines"], ","),
      origin: params["origin"],
      destination: params["destination"],
      departure: params["departure"],
      returning: params["returning"]
    )
  end

  defp metadata(params), do: Metadata.create(site: params["site"], brand: params["brand"], channel: params["channel"])
end
