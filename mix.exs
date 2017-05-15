defmodule Polcom.Mixfile do
  use Mix.Project

  def project do
    [app: :polcom,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
        mod: {Polcom, []},
        applications: [
          :phoenix, :phoenix_pubsub, :cowboy, :logger, :gettext, :phoenix_ecto,
          :mongodb, :poolboy, :logger_file_backend, :uuid, :httpoison
        ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:mongodb, ">= 0.0.0"},
      {:poolboy, ">= 0.0.0"},
      {:httpoison, "~> 0.9.0"},
      {:uuid, "~> 1.1"},
      {:logger_file_backend, "0.0.8"},
      {:exrm, "~> 1.0.8"},
      {:timex, "~> 3.0"},
      {:exjsx, "~> 4.0.0", git: "https://github.com/talentdeficit/exjsx"},
      {:phoenix_live_reload, "~> 1.0", only: :dev}
    ]
  end
end
