use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :polcom, Polcom.Endpoint,
  http: [port: 8080],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :polcom, :polcom,
    hostname: "mongo01st.almundo.it",
    post: "27017",
    database: "polcom",
    username: "polcom",
    password: "Almundo2015",
    timeout: 300_000,
    pool_timeout: 300_000

config :polcom, :fop,
    hostname: "mongo01st.almundo.it",
    post: "27017",
    database: "fop",
    timeout: 300_000,
    pool_timeout: 300_000

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20
