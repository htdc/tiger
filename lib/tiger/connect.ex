defmodule Tiger.Connect do
  @moduledoc """
  """
  alias Tiger.Config
  alias Tesla.Client

  def connect_client(%Config{} = config) do
    Tiger.Client.new(config, endpoint_path())
  end

  def oauth_token_callback(%Client{} = client, code) do
    Tesla.post(client, "/oauth/token", %{
      code: code,
      grant_type: "authorization_code"
    })
  end

  defp endpoint_path do
    "https://connect.stripe.com"
  end
end
