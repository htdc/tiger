defmodule Tiger.ConnectTest do
  use ExUnit.Case, async: true

  use Nug,
    upstream_url: "https://connect.stripe.com",
    client_builder: &TestClient.setup/1

  alias Tiger.Structs.Connect

  test "Can connect account" do
    with_proxy("connect.fixture") do
      {:ok, %Tesla.Env{body: %Connect{} = body}} =
        Tiger.Connect.oauth_token_callback(client, "ac_IUqXA35rPtA8xmREuOi5rMKJ6qIlteW0")

      assert body.stripe_user_id == "acct_1HtqZmFVnuhDRM3U"
      assert body.token_type == "bearer"
      assert body.livemode == false
    end
  end
end
