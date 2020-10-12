defmodule Tiger.BalanceTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Balance

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can retrieve balance" do
    with_proxy("balance.fixture") do
      {:ok, %Tesla.Env{body: %Balance{} = balance}} = Tiger.Balance.get(client)

      assert balance.available == [
               %{amount: 105_207, currency: "aud", source_types: %{card: 105_207}}
             ]

      refute balance.instant_available

      assert balance.connect_reserved == [%{amount: 0, currency: "aud"}]

      assert balance.pending == [%{amount: 0, currency: "aud", source_types: %{card: 0}}]
    end
  end
end
