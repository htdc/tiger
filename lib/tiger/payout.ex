defmodule Tiger.Payout do
  @moduledoc """
  Used for interacting with Payouts
  """
  alias Tesla.Client

  @doc """
  Cancel a payout
  """
  def cancel(%Client{} = client, payout_id) when is_binary(payout_id) do
    Tesla.post(client, "#{endpoint_path()}/#{payout_id}/cancel", nil)
  end

  @doc """
  Create a payout
  """
  def create(%Client{} = client, params) when is_map(params) do
    Tesla.post(client, endpoint_path(), FormSafe.encode(params))
  end

  @doc """
  Get a payout
  """
  def get(%Client{} = client, payout_id) when is_binary(payout_id) do
    Tesla.get(client, "#{endpoint_path()}/#{payout_id}")
  end

  @doc """
  List payouts
  """
  def list(%Client{} = client, opts \\ []) do
    Tesla.get(client, endpoint_path(), opts)
  end

  @doc """
  Update a payout
  """
  def update(%Client{} = client, payout_id, params)
      when is_binary(payout_id) and is_map(params) do
    Tesla.post(client, "#{endpoint_path()}/#{payout_id}", FormSafe.encode(params))
  end

  defp endpoint_path do
    "payouts"
  end
end
