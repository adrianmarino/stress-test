defmodule Polcom.Repo.Config, do: def config, do: Application.get_env(:polcom, :mongo)
