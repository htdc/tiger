defmodule Tiger.Middleware.Transform do
  @moduledoc false
  alias Tesla.Env
  alias Tiger.Structs.{Balance, Charge, Transfer}
  # import Tiger.Middleware.TransformMacro
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

  defp to_struct(%Env{body: %{object: "balance"} = balance} = env) do
    struct(Balance, balance)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "charge"} | _] = charges}} = env) do
    Enum.map(charges, fn charge -> struct(Charge, charge) end)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{object: "charge"} = charge} = env) do
    struct(Charge, charge)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "transfer"} | _] = transfers}} = env) do
    Enum.map(transfers, fn transfer -> struct(Transfer, transfer) end)
    |> replace_body(env)
  end


  defp to_struct(%Env{body: %{object: "transfer"} = transfer} = env) do
    struct(Transfer, transfer)
    |> replace_body(env)
  end

  defp to_struct(any), do: any

  defp replace_body(struct, env) do
    raw_body = env.body
    new_opts = Keyword.put(env.opts, :raw_body, raw_body)

    %{env | body: struct, opts: new_opts}
  end
end
