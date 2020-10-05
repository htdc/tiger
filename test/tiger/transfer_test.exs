defmodule Tiger.TransferTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Transfer

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can retrieve a transfer" do
    with_proxy("get_transfer.fixture") do
      {:ok, %Tesla.Env{body: %Transfer{} = transfer}} =
        Tiger.Transfer.get(client, "tr_1HYr2GClStGc5XwOOGvh3z4E")

      assert transfer.id == "tr_1HYr2GClStGc5XwOOGvh3z4E"
    end
  end

  test "Can update a transfer" do
    with_proxy("update_transfer.fixture") do
      {:ok, %Tesla.Env{body: %Transfer{} = transfer}} =
        Tiger.Transfer.update(client, "tr_1HYr2GClStGc5XwOOGvh3z4E", %{
          metadata: %{
            update: "You Bet!"
          }
        })

      assert transfer.id == "tr_1HYr2GClStGc5XwOOGvh3z4E"
      assert transfer.metadata == %{update: "You Bet!"}
    end
  end

  test "Can list transfers" do
    with_proxy("list_transfers.fixture") do
      {:ok, %Tesla.Env{body: transfers}} = Tiger.Transfer.list(client)

      [%Transfer{} = first | _] = transfers

      assert first.amount == 2000
      assert length(transfers) == 10
    end
  end

  test "Can retrieve a list of transfers with query parameters" do
    with_proxy("list_transfers_with_query.fixture") do
      {:ok, %Tesla.Env{body: transfers}} = Tiger.Charge.list(client, limit: 20)

      assert length(transfers) == 20
    end
  end

  # Can't currently get this working in test env
  # Only works with USD in test mode
  #
  # test "Can create a transfer" do
  #   with_proxy("create_transfer.fixture") do
  #     {:ok, %Tesla.Env{body: %Transfer{} = transfer}} =
  #       Tiger.Transfer.create(client, %{
  #         amount: 2000,
  #         currency: "aud",
  #         destination: "acct_1HSZKXFFwAeTesFQ"
  #       })

  #     assert transfer.id == "tr_1HYr2GClStGc5XwOOGvh3z4E"
  #     assert transfer.metadata == %{update: "You Bet!"}
  #   end
  # end
end
