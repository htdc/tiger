defmodule Tiger.Refund do
  @moduledoc """
  Used for interacting with Refunds
  """
  alias Tesla.Client

  @doc """
  Create a refund
  """

  def create(%Client{} = client, charge_id, params \\ %{}) when is_binary(charge_id) do
    with_charge_id = Map.merge(%{charge: charge_id}, params)
    Tesla.post(client, endpoint_path(), FormSafe.encode(with_charge_id))
  end

  @doc """
  Create a refund and reverse a Connect Transfer
  """

  def create_with_reversal(%Client{} = client, charge_id, params \\ %{})
      when is_binary(charge_id) do
    with_charge_id = Map.merge(%{charge: charge_id, reverse_transfer: true}, params)
    Tesla.post(client, endpoint_path(), FormSafe.encode(with_charge_id))
  end

  @doc """
  Retrieve a refund
  """
  def get(%Client{} = client, charge_id, opts \\ []) when is_binary(charge_id) do
    Tesla.get(client, "#{endpoint_path()}/#{charge_id}", opts)
  end

  @doc """
  List refunds
  """
  def list(%Client{} = client, opts \\ []) do
    Tesla.get(client, endpoint_path(), opts)
  end

  @doc """
  Update a refund
  """
  def update(%Client{} = client, charge_id, params)
      when is_binary(charge_id) and is_map(params) do
    Tesla.post(client, "#{endpoint_path()}/#{charge_id}", FormSafe.encode(params))
  end

  defp endpoint_path do
    "refunds"
  end
end
