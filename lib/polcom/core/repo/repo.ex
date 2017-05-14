import Core.KeywordListUtil, only: [sub_list: 2]
import Core.Repo.Config
import Enum, only: [to_list: 1]

defmodule Core.Repo do
  defstruct [:database, :collection]

  def create(database, collection) do
    %Core.Repo{database: database, collection: collection}
  end

  def find(repo, query \\ %{}, opts \\ []) do
    to_list(Mongo.find(repo.database, repo.collection, query, default_opts(repo, opts)))
  end

  defp default_opts(repo, opts) do
    opts ++
    sub_list(config(repo.database), [:timeout, :pool_timeout]) ++
    [pool: DBConnection.Poolboy]
  end
end
