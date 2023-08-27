# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :undi_online, :env, Mix.env()

config :undi_online,
  ecto_repos: [UndiOnline.Repo],
  generators: [binary_id: true]

config :undi_online, UndiOnline.Repo,
  migration_primary_key: [name: :id, type: :binary_id]


# Configures the endpoint
config :undi_online, UndiOnlineWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: UndiOnlineWeb.ErrorHTML, json: UndiOnlineWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: UndiOnline.PubSub,
  live_view: [signing_salt: "48eGZ5fl"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :undi_online, UndiOnline.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :undi_online, UndiOnline.Users.Guardian,
  issuer: "undi_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "FQKR86G40nm8kNvjrIkHhTUQN7KvwWUlIH39ls/V+43JdrvI9qw8gSLJLEl5vwvg"


config :undi_online, UndiOnline.Admins.Guardian,
  issuer: "undi_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "9kpeXOhHPouoWiqU7s2NSEIYSYMHqCVw0lOOgtlD3q6k7GcEfR6/UFWB1/QXpbDB"


config :undi_online, Oban,
  repo: UndiOnline.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", UndiOnline.Workers.DailyDigestWorker},
       # {"@reboot", UndiOnline.Workers.StripeSyncWorker},
       # {"0 2 * * *", UndiOnline.DailyReports.DailyReportWorker},
     ]}
  ]

config :flop, repo: UndiOnline.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
