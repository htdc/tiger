defmodule Tiger.RefundTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Refund

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can create a refund" do
    with_proxy("create_refund.fixture") do
      {:ok, %Tesla.Env{body: %Refund{} = refund}} =
        Tiger.Refund.create(client, "ch_1HYr2GClStGc5XwOogX26olX")

      assert refund.id == "re_1HcBVCClStGc5XwOwiYDIPbw"
      assert refund.amount == 2000
    end
  end


  test "Can create a refund with reversal for Connect payments" do
    with_proxy("create_refund_connect.fixture") do
      {:ok, %Tesla.Env{body: %Refund{} = refund}} =
        Tiger.Refund.create_with_reversal(client, "ch_1H8N2ZClStGc5XwOBaJR5QSx")

      assert refund.id == "re_1HgnOSClStGc5XwOshGv17Ve"
      assert refund.transfer_reversal == "trr_1HgnOTClStGc5XwObI6JnqnG"
    end
  end

  test "Can retrieve a refund" do
    with_proxy("get_refund.fixture") do
      {:ok, %Tesla.Env{body: %Refund{} = refund}} =
        Tiger.Refund.get(client, "re_1HcBVCClStGc5XwOwiYDIPbw")

      assert refund.id == "re_1HcBVCClStGc5XwOwiYDIPbw"
    end
  end

  test "Can update a refund" do
    with_proxy("update_refund.fixture") do
      {:ok, %Tesla.Env{body: %Refund{} = refund}} =
        Tiger.Refund.update(client, "re_1HcBVCClStGc5XwOwiYDIPbw", %{
          metadata: %{
            reason: "Faulty Product"
          }
        })

      assert refund.metadata == %{reason: "Faulty Product"}
    end
  end

  test "Can list refunds" do
    with_proxy("list_refunds.fixture") do
      {:ok, %Tesla.Env{body: refunds}} =
        Tiger.Refund.list(client)

      [%Refund{} = first | _] = refunds

      assert length(refunds) == 10

      assert first.amount == 2000
    end
  end

  test "Can list refunds with params" do
    with_proxy("list_refunds_with_params.fixture") do
      {:ok, %Tesla.Env{body: refunds}} =
        Tiger.Refund.list(client, limit: 2)

      assert length(refunds) == 2
    end
  end
end
