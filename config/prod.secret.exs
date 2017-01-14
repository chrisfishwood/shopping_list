use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :shopping_list, ShoppingList.Endpoint,
  secret_key_base: "4xFRNb6YVhBqy2NkZtmvmU+hYO2Ewx4wfeukIBKC+hkMGSwmDiUc2u3xlMKoat7Z"

# Configure your database
config :shopping_list, ShoppingList.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "shopping_list_prod",
  pool_size: 20
