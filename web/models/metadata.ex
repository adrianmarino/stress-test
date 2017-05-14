defmodule Polcom.Metadata do
  defstruct [:site, :brand, :channel]

  def create(site: site, brand: brand, channel: channel) do
    %Polcom.Metadata{site: site, brand: brand, channel: channel}
  end
end
