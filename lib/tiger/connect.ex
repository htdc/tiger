defmodule Tiger.Connect do
  @moduledoc """
  """
  alias Tiger.Config
  alias Tesla.Client

  def connect_client(%Config{} = config, url \\ endpoint_path()) do
    Tiger.Client.new(config, url)
  end

  def oauth_token_callback(%Client{} = client, code) do
    Tesla.post(client, "/oauth/token", %{
      code: code,
      grant_type: "authorization_code"
    })
  end

  def endpoint_path do
    "https://connect.stripe.com"
  end
end
