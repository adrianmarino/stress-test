defmodule Polcom.Router do
  use Polcom.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/polcom", Polcom do
    pipe_through :api
    get "/credit-cards/operating-costs", FlightController, :find
  end
end
