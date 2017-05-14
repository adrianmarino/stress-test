alias Polcom.Policy

defmodule Polcom.MetadataMatcher do
  def match?(%Polcom.Metadata{} = metadata, policy) do
    has_brand?(policy, metadata.brand) and
    has_site?(policy, metadata.site) and
    has_channel?(policy, metadata.channel)
  end

  defp has_brand?(_, ""), do: true
  defp has_brand?(_, nil), do: true
  defp has_brand?(policy, value), do: Enum.member?(Policy.brands(policy), value)

  defp has_site?(_, ""), do: true
  defp has_site?(_, nil), do: true
  defp has_site?(policy, value), do: Policy.site(policy) == value

  defp has_channel?(_, ""), do: true
  defp has_channel?(_, nil), do: true
  defp has_channel?(policy, value), do: Enum.member?(Policy.channels(policy), value)
end
