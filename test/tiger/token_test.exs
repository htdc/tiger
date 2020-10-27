defmodule Tiger.TokenTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Token

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can create a token" do
    with_proxy("create_token.fixture") do
      {:ok, %Tesla.Env{body: %Token{} = token}} =
        Tiger.Token.create(client, %Token{
          card: %{
            number: "4242424242424242",
            exp_month: 12,
            exp_year: 2030,
            cvc: 123
          }
        })

      assert token.id == "tok_1HgmsuClStGc5XwO9g6l4MEp"
    end
  end

  test "Can create a token from keyword params" do
    with_proxy("create_token_keyword.fixture") do
      {:ok, %Tesla.Env{body: %Token{} = token}} =
        Tiger.Token.create(client,
          card: [
            number: "4242424242424242",
            exp_month: 12,
            exp_year: 2030,
            cvc: 123
          ]
        )

      assert token.id == "tok_1Hgmz1ClStGc5XwOu6BqQL57"
    end
  end
end
