# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shopping_list,
  ecto_repos: [AuthExample.Repo]

# Configures the endpoint
config :shopping_list, AuthExample.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tl1zdl2/sOFwlE8GCC7axv5WdAgG5V44AjX0O3OoadCeRqwT6NWpssIT1UY2UY/m",
  render_errors: [view: AuthExample.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthExample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

  #TODO: regen the secret key and move to an ENV var
  #jwk = JOSE.JWK.generate_key({:ec, "P-521"}) |> JOSE.JWK.to_map |> elem(1)
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "AuthExample",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "xeCJmtGYz7OQ9+j3zpdGmKkI3mvmygERVILksEj2EvzVdJlZVgNJQO1t6jlFAtvV",
  #secret_key: %{
    #"crv" => "P-521",
    #"d" => "axDuTtGavPjnhlfnYAwkHa4qyfz2fdseppXEzmKpQyY0xd3bGpYLEF4ognDpRJm5IRaM31Id2NfEtDFw4iTbDSE",
    #"kty" => "EC",
    #"x" => "AL0H8OvP5NuboUoj8Pb3zpBcDyEJN907wMxrCy7H2062i3IRPF5NQ546jIJU3uQX5KN2QB_Cq6R_SUqyVZSNpIfC",
    #"y" => "ALdxLuo6oKLoQ-xLSkShv_TA0di97I9V92sg1MKFava5hKGST1EKiVQnZMrN3HO8LtLT78SNTgwJSQHAXIUaA-lV"
  #},
  serializer: AuthExample.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
