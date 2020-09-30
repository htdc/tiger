defmodule Tiger.Client do
  @moduledoc """
  Used for building a Tesla client for use with the Stripe API
  """
  alias Tiger.Config

  @doc """
  Create a new `Tesla.Client`

  ## Parameters
  - `config` is [`%Config{}`](`Tiger.Config`) struct
  """
  def new(%Config{} = config) do
    new(config, default_url(), default_adapter())
  end

  @doc """
  Create a new `Tesla.Client`

  ## Parameters
  - `secrets` is [`%Config{}`](`Tiger.Config`) struct
  - `url` allows you to override the URL where requests will be sent.  Useful for testing
  """
  def new(%Config{} = config, url) do
    new(config, url, default_adapter())
  end

  @doc """
  Create a new `Tesla.Client`

  ## Parameters
  - `secrets` is [`%Config{}`](`Tiger.Config`) struct
  - `url` allows you to override the URL where requests will be sent.  Useful for testing
  - `adapter` Allows you to use a different `Tesla.Adapter` to the default which is `Tesla.Adapter.Gun`
  """
  def new(%Config{} = config, url, adapter) do
    middleware = [
      Tesla.Middleware.Query,
      {Tesla.Middleware.BasicAuth, [username: config.api_key]},
      {Tesla.Middleware.BaseUrl, url},
      Tiger.Middleware.Transform,
      Tesla.Middleware.KeepRequest,
      Tesla.Middleware.Compression,
      Tesla.Middleware.Logger,
      {Tesla.Middleware.JSON, [engine_opts: [keys: :atoms]]}
    ]

    Tesla.client(middleware, adapter)
  end

  @doc """
  Default adapter to be used for making requests.
  """
  def default_adapter do
    Application.get_env(:ex_spreedly, :adapter, {Tesla.Adapter.Gun, [timeout: 30_000]})
  end

  @doc """
  Default URL for communicating with Stripe
  """
  def default_url do
    Application.get_env(:ex_spreedly, :url, "https://api.stripe.com")
  end
end
