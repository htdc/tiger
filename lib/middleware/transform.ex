defmodule Stripe.Middleware.Transform do
  @moduledoc false
  alias Tesla.Env
  # alias Spreedly.Structs.{Gateway, PaymentMethod, Response, Transaction}
  # import Spreedly.Middleware.TransformMacro
  @behaviour Tesla.Middleware

  def call(%Env{} = env, next, _options) do
    with {:ok, response} <- Tesla.run(env, next),
         {:ok, transformed} <- transform(response) do
      {:ok, transformed}
    end
  end

  defp transform(%Env{status: status} = env) when status in 200..299 do
    {:ok, to_struct(env)}
  end

  defp transform(%Env{status: status} = env) when status in 400..599 do
    {:error, to_struct(env)}
  end

  defp to_struct(any), do: any

  defp replace_body(struct, env) do
    raw_body = env.body
    new_opts = Keyword.put(env.opts, :raw_body, raw_body)

    %{env | body: struct, opts: new_opts}
  end
end
