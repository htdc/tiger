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

  @doc """
  Retrieve all Connect accounts
  """
  def list(%Client{} = client, opts \\ []) do
    Tesla.get(client, endpoint_path(), opts)
  end

  @doc """
  Delete a connected account
  """
  def delete(%Client{} = client, id) when is_binary(id) do
    Tesla.delete(client, endpoint_path() <> "/#{id}")
  end

  def endpoint_path() do
    "accounts"
  end
end
