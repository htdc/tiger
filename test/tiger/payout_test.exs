defmodule Tiger.PayoutTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Payout

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can create a payout" do
    with_proxy("create_payout.fixture") do
      {:ok, %Tesla.Env{body: %Payout{} = payout}} =
        Tiger.Payout.create(client, %{amount: 200, currency: "aud"})

      assert payout.id == "po_1HcKHuClStGc5XwOFm8IT0Qu"
    end
  end

  test "Can get a payout" do
    with_proxy("get_payout.fixture") do
      {:ok, %Tesla.Env{body: %Payout{} = payout}} =
        Tiger.Payout.get(client, "po_1HcKHuClStGc5XwOFm8IT0Qu")

      assert payout.id == "po_1HcKHuClStGc5XwOFm8IT0Qu"
    end
  end

  test "Can update a payout" do
    with_proxy("update_payout.fixture") do
      {:ok, %Tesla.Env{body: %Payout{} = payout}} =
        Tiger.Payout.update(client, "po_1HcKHuClStGc5XwOFm8IT0Qu", %{
          metadata: %{
            internal_id: 123
          }
        })

      assert payout.metadata == %{internal_id: "123"}
    end
  end

  test "Can list payouts with params" do
    with_proxy("list_payouts_with_params.fixture") do
      {:ok, %Tesla.Env{body: payouts}} = Tiger.Payout.list(client, query: [limit: 2])

      [%Payout{} = first | _] = payouts

      assert first.id == "po_1HcKHuClStGc5XwOFm8IT0Qu"
      assert length(payouts) == 2
    end
  end

  test "Can list payouts for connect account" do
    with_proxy("list_payouts_with_params.fixture") do
      {:ok, %Tesla.Env{body: payouts}} = Tiger.Payout.list(client, headers: [{"stripe-account", ""}], query: [limit: 2, expand: []])

      [%Payout{} = first | _] = payouts

      assert first.id == "po_1HcKHuClStGc5XwOFm8IT0Qu"
      assert length(payouts) == 2
    end
  end



end
