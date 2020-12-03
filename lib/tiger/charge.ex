defmodule Tiger.Charge do
  @moduledoc """
  Used for interacting with Charges
  """
  alias Tesla.Client
  alias Tiger.Structs.CreateCharge

  @doc """
  Make a charge
  """
  def create(%Client{} = client, %CreateCharge{} = params) do
    Tesla.post(client, endpoint_path(), FormSafe.encode(params))
  end

  def create(%Client{} = client, params) when is_map(params) do
    Tesla.post(client, endpoint_path(), FormSafe.encode(params))
  end

  def capture(%Client{} = client, id, params \\ nil) do
    Tesla.post(client, "#{endpoint_path()}/#{id}/capture", FormSafe.encode(params))
  end

  @doc """
  Retrieve a charge
  """
  def get(%Client{} = client, id) when is_binary(id) do
    Tesla.get(client, "#{endpoint_path()}/#{id}")
  end

  def get(%Client{} = client, id, opts) when is_binary(id) and is_list(opts) do
    Tesla.get(client, "#{endpoint_path()}/#{id}", opts)
  end

  @doc """
  Update a charge
  """
  def update(%Client{} = client, id, params) when is_map(params) do
    Tesla.post(client, "#{endpoint_path()}/#{id}", FormSafe.encode(params))
  end

  @doc """
  List charges

  ## Parameters

  Passed as a keyword list e.g. `[order: "desc"]`
  """
  def list(%Client{} = client, opts \\ []) do
    Tesla.get(client, endpoint_path(), opts)
  end

  defp endpoint_path do
    "charges"
  end
end
