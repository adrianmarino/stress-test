alias Core.MongoStoreFactory
alias Core.Store
import Enum, only: [filter: 2]

defmodule Polcom.OperatingBasisRepo do
  def init do
    MongoStoreFactory.create(
      name: __MODULE__,
      database: :fop,
      collection: "operatingBasis",
      filter: %{}
    )
  end

  def find_by(criterion), do: Store.get(__MODULE__) |> filter(criterion)
end
