defmodule Polcom.Flight do
  defstruct [:type, :airlines, :origin, :destination, :departure, :returning]

  def create(airlines: airlines, origin: origin, destination: destination,
            departure: departure, returning: returning) do
    %Polcom.Flight{
      type: "FLIGHT",
      airlines: airlines,
      origin: origin,
      destination: destination,
      departure: departure,
      returning: returning
    }
  end
end
