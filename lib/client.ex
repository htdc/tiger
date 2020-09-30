defmodule Tiger.Client do
  alias Tiger.Config

  def new(%Config{} = secrets) do
    new(secrets, default_url(), default_adapter())
  end

  def new(%Config{} = secrets, url) do
    new(secrets, url, default_adapter())
  end

  def new(%Config{} = config, url, adapter) do
    middleware = [
      Tesla.Middleware.Query,
      {Tesla.Middleware.BasicAuth, [username: config.api_key]},
      {Tesla.Middleware.BaseUrl, url},
      Stripe.Middleware.Transform,
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
