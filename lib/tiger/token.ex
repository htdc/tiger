defmodule Tiger.Token do
  @moduledoc """
  Used for interacting with Tokens
  """
  alias Tesla.Client
  alias Tiger.Structs.Token

  def create(%Client{} = client, %Token{} = params) do
    Tesla.post(client, endpoint_path(), FormSafe.encode(params))
  end

  def create(%Client{} = client, params) when is_list(params) do
    Tesla.post(client, endpoint_path(), params)
  end

  defp endpoint_path do
    "tokens"
  end
end
