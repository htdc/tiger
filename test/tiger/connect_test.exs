defmodule Tiger.ConnectTest do
  use ExUnit.Case, async: true

  use Nug,
    upstream_url: "https://connect.stripe.com",
    client_builder: &TestClient.setup/1

  alias Tiger.Structs.Connect

  test "Can connect account" do
    with_proxy("connect.fixture") do
      {:ok, %Tesla.Env{body: %Connect{} = body}} =
        Tiger.Connect.oauth_token_callback(client, "ac_Ia8XDvk1MeP6Pgi0tEnmpdxP6HAY6YnW")

      assert body.stripe_user_id == "acct_1HyyDgK4GJpnpSAF"
      assert body.token_type == "bearer"
      assert body.livemode == false
    end
  end
end
