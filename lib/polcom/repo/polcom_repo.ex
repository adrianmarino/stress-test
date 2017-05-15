alias Core.{MongoStoreFactory, Store}
import Enum, only: [filter: 2]

defmodule Polcom.PolcomRepo do
  def init do
    MongoStoreFactory.create(
      name: __MODULE__,
      database: :polcom,
      collection: "commercialPolicy",
      filter: %{ active: true, type: %{ value: 4},  expire_date: %{ "$gte": to_str(Timex.now) }}
    )
  end

  def find_by(criterion), do: Store.get(__MODULE__) |> filter(criterion)

  defp to_str(date_time), do: Timex.format!(date_time, "%FT%H:%M", :strftime)
end
