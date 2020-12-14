defmodule Tiger.BalanceTransaction do
  @moduledoc """
  Balance transactions represent funds moving through your Stripe account.
  They're created for every type of transaction that comes into or flows out of your
  Stripe account balance.
  """
  alias Tesla.Client

  @doc """
  Retrieve a balance transaction.
  """
  def get(%Client{} = client, id, opts \\ []) when is_binary(id) do
    Tesla.get(client, endpoint_path() <> "/#{id}", opts)
  end

  @doc """
  Retrieve all balance transactions
  """
  def list(%Client{} = client, opts \\ []) do
    Tesla.get(client, endpoint_path(), opts)
  end

  defp endpoint_path do
    "balance_transactions"
  end
end
