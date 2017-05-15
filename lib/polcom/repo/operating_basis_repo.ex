alias Core.{MongoStoreFactory, Store}

defmodule Polcom.OperatingBasisRepo do
  def init do
    MongoStoreFactory.create(
      name: __MODULE__,
      database: :fop,
      collection: "operatingBasis",
      filter: %{}
    )
  end

  def all(), do: Store.get(__MODULE__)
end
