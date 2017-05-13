defmodule Polcom.Router do
  use Polcom.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Polcom do
    pipe_through :api
  end
end
