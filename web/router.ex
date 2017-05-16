defmodule Polcom.Router do
  use Polcom.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/abs/fops", Polcom do
    pipe_through :api
    get "/flights/credit-cards/operating-costs", FlightController, :find
  end
end
