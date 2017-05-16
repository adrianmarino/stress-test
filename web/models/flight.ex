defmodule Polcom.Flight do
  defstruct [:airlines, :origin, :destination, :departure, :returning]

  def create(airlines: airlines, origin: origin, destination: destination,
            departure: departure, returning: returning) do
    %Polcom.Flight{airlines: airlines, origin: origin, destination: destination,
            departure: departure, returning: returning}
  end
end
