ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Wallet.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Wallet.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Wallet.Repo)

