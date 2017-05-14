alias Core.Repo
alias Core.Store
alias Core.Profiler

defmodule Core.MongoStoreFactory do
  def create(name: name, database: database, collection: collection, filter: filter) do
    IO.puts("...loading documents from \"#{collection}\" collection filtered by: #{inspect(filter)} from #{to_string(database)} database.")
    repo = Repo.create(database, collection)
    result = Profiler.time(fn -> Repo.find(repo, filter, limit: 500) end)
    IO.puts("...#{Enum.count(result.return)} document/s found in #{result.time}")

    Store.create(name, result.return)
  end
end
