import Core.KeywordListUtil, only: [sub_list: 2]
import Polcom.Repo.Config
import Polcom.Repo.Query
import Enum, only: [to_list: 1]

defmodule Polcom.Repo do

  @collection "commercialPolicy"

  def find_first, do: find(%{}, limit: 1)

  def find_all, do: find()

  def find(query \\ %{}, opts \\ []) do
    query = is_pricing(query)
    IO.inspect("Query: #{inspect(query)}")

    opts = default_opts(opts)
    IO.inspect("Options: #{inspect(opts)}")

    to_list(Mongo.find(:mongo, @collection, query, opts))
  end

  defp default_opts(opts) do
    opts ++
    sub_list(config(), [:timeout, :pool_timeout]) ++
    [pool: DBConnection.Poolboy]
  end
end
