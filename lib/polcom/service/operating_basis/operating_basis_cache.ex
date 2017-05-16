alias Core.{Store, StringUtil}

defmodule Polcom.OperatingBasisCache do
  def create(list) do
    Store.create(
      __MODULE__,
      list |> Enum.map(fn basis ->
        {
            BSON.ObjectId.encode!(basis["_id"]),
            basis["percents"]
              |> Enum.map(&({Integer.to_string(&1["installments"]), to_percent(&1["percent"])}))
              |> Enum.into(%{})
        }
      end)  |> Enum.into(%{})
    )
  end

  def get(id) do
    case Map.get(all(), id) do
      nil -> %{}
      basis -> basis
    end
  end

  def ids(), do: Map.keys(all())

  def all, do: Store.get(__MODULE__)

  defp to_percent(value) when is_bitstring(value), do: StringUtil.to_number(value)
  defp to_percent(value) when is_integer(value), do: value
  defp to_percent(value), do: String.to_float(value)
end
