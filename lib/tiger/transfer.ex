defmodule Tiger.Transfer do
  @moduledoc """
  Used for interacting with Transfers
  """
  alias Tesla.Client

  @doc """
  Create a transfer
  """
  def create(%Client{} = client, params) when is_map(params) do
    Tesla.post(client, base_url(), FormSafe.encode(params))
  end

  @doc """
  Retrieve a transfer
  """
  def get(%Client{} = client, id) when is_binary(id) do
    Tesla.get(client, "#{base_url()}/#{id}")
  end

  @doc """
  List transfers
  """
  def list(%Client{} = client, query \\ []) do
    Tesla.get(client, base_url(), query: query)
  end

  @doc """
  Update a transfer
  """
  def update(%Client{} = client, id, params) when is_map(params) do
    Tesla.post(client, "#{base_url()}/#{id}", params)
  end

  defp base_url() do
    "transfers"
  end
end
