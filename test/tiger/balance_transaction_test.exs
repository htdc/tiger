defmodule Tiger.BalanceTransactionTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.{BalanceTransaction}

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can retrieve a balance transaction" do
    with_proxy("get_balance_transaction.fixture") do
      {:ok, %Tesla.Env{body: %BalanceTransaction{} = bt}} =
        Tiger.BalanceTransaction.get(client, "txn_1HYu43ClStGc5XwO2Mjnmn2t")

      assert bt.status == "available"
    end
  end

  test "Can retrieve balance transactions" do
    with_proxy("list_balance_transactions.fixture") do
      {:ok, %Tesla.Env{body: balance_transactions}} = Tiger.BalanceTransaction.list(client)
      [%BalanceTransaction{} = first | _] = balance_transactions

      assert first.amount == -2000
      assert first.currency == "aud"
      assert first.id == "txn_1HYu43ClStGc5XwO2Mjnmn2t"
      assert length(balance_transactions) == 10
    end
  end

  test "Can pass query params balance transactions" do
    with_proxy("list_balance_transactions_query.fixture") do
      {:ok, %Tesla.Env{body: balance_transactions}} =
        Tiger.BalanceTransaction.list(client, limit: 3)

      assert length(balance_transactions) == 3
    end
  end
end
