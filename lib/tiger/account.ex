defmodule Tiger.Account do
  @moduledoc """
  Used for interacting Connect Accounts
  """
  alias Tesla.Client

  @doc """
  Create an account
  """
  def create(%Client{} = client, params) when is_map(params) do
    Tesla.post(client, endpoint_path(), FormSafe.encode(params))
  end

  def endpoint_path() do
    "accounts"
  end
end
