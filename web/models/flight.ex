defmodule Polcom.Flight do
  defstruct [:type, :airline, :origin, :destination, :departure, :returning]

  def create(airline: airline, origin: origin, destination: destination,
            departure: departure, returning: returning) do
    %Polcom.Flight{airline: airline, origin: origin, destination: destination,
            departure: departure, returning: returning}
  end
end
