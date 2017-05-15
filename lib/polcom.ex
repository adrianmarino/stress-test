alias Polcom.{OperatingBasisRepo, OperatingBasisCache, PolcomRepo}

import Core.Repo.Config

defmodule Polcom do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(Polcom.Endpoint, []),
      # Start your own worker by calling: Polcom.Worker.start_link(arg1, arg2, arg3)
      # worker(Polcom.Worker, [arg1, arg2, arg3]),
      worker(Mongo, [[name: :polcom, pool: DBConnection.Poolboy] ++ config(:polcom)], id: :polcom),
      worker(Mongo, [[name: :fop, pool: DBConnection.Poolboy] ++ config(:fop)], id: :fop)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Polcom.Supervisor]
    result = Supervisor.start_link(children, opts)

    spawn fn-> initialize_in_memory_stores() end
    result
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Polcom.Endpoint.config_change(changed, removed)
    :ok
  end

  defp initialize_in_memory_stores do
    OperatingBasisRepo.init()

    basis = OperatingBasisRepo.all()
    OperatingBasisCache.create(basis)

    PolcomRepo.init()
  end
end
