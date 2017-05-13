defmodule Polcom.Repo.Query do
  def is_pricing(query), do: Map.merge(is_pricing(), query)
  def is_pricing, do: %{type: %{value: 4}}
end
