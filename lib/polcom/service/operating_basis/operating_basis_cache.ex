alias Core.Store

defmodule Polcom.OperatingBasisCache do
  def create(list) do
    Store.create(
      __MODULE__,
      list |> Enum.map(fn basis ->
        {
            BSON.ObjectId.encode!(basis["_id"]),
            basis["percents"] |> Enum.map(&({&1["installments"], &1["percent"]})) |> Enum.into(%{})
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
end
