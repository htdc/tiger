defmodule TestClient do
  @moduledoc """
  Helper functions for use during testing
  """

  @doc """
  Convenience function for building a test environment client
  """
  def setup(address) do
    Process.put(:client_url, address)

    Tiger.Client.new(config(), address)
  end

  @doc """
  Read config from system environment variables
  """
  def config do
    %Tiger.Config{
      api_key: System.get_env("STRIPE_TEST_API_KEY")
    }
  end
end
