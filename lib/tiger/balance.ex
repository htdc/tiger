defmodule Tiger.Balance do
  @moduledoc """
  Used for interacting with Balances
  """
  alias Tesla.Client

  @doc """
  Returns a balance object for the account that was authenticated in the request.
  """
  def get(%Client{} = client) do
    Tesla.get(client, endpoint_path())
  end

  defp endpoint_path() do
    "balance"
  end
end
