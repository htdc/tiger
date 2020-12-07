defmodule Tiger.Connect do
  @moduledoc """
  Used for interacting with Stripe's Connect OAuth process
  """
  alias Tiger.Config
  alias Tesla.Client

  @doc """
  Builds a client for interacting with Connect.  Handled separately from the main client because
  the endpoint lives at a different location.
  """
  def connect_client(%Config{} = config, url \\ endpoint_path()) do
    Tiger.Client.new(config, url)
  end

  @doc """
  Send the `code` your Connect user request returned to Stripe for finalization.
  """
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
