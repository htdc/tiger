defmodule Tiger.ChargeTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Charge
  alias Tiger.Structs.CreateCharge

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can make a charge" do
    with_proxy("create_charge.fixture") do
      {:ok, charge} =
        Charge.create(client, %CreateCharge{
          amount: 2000,
          source: "tok_amex"
        })
    end
  end
end
