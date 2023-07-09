# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :dockview,
  ecto_repos: [Dockview.Repo]

# Configure your database
config :dockview, Dockview.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "dockview",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configures the endpoint
config :dockview, DockviewWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DockviewWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dockview.PubSub,
  secret_key_base: "kh5nqyB3Q5/LOZkRD/r85wddpWOCI6qX/7ixnghM2hd4WFz3N8enVFPx/8gu2w5E",
  live_view: [signing_salt: "b3Y+GMZh"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :dockview, Dockview.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
