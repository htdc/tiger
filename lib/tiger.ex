defmodule Tiger do
  def headers(key, value) when is_binary(key) do
    [headers: [{key, value}]]
  end

  @doc """
  Builds headers Keyword list for Stripe Connect requests
  """
  def account_header(account_id) when is_binary(account_id) do
    headers("stripe-account", account_id)
  end

  def query([]), do: []


  def query(terms) when is_list(terms) do
    [query: terms]
  end

  @doc """
  Build options for making a scoped request with optional query parameters

  iex> Tiger.connect_options("abc123", type: "payment", limit: 3)
  [headers: [{"stripe-account", "abc123"}], query: [type: "payment", limit: 3]]
  """
  def connect_options(account_id, query \\ []) when is_binary(account_id) do
    Keyword.merge(account_header(account_id), query(query))
  end
end
