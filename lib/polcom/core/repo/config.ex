defmodule Core.Repo.Config, do: def config(database), do: Application.get_env(:polcom, database)
