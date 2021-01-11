defmodule Tiger.Middleware.Transform do
  @moduledoc false
  alias Tesla.Env

  alias Tiger.Structs.{
    Account,
    Balance,
    BalanceTransaction,
    Charge,
    Connect,
    Transfer,
    Refund,
    Payout,
    Token
  }

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

  defp to_struct(%Env{body: %{object: "balance_transaction"} = balance_transaction} = env) do
    struct(BalanceTransaction, balance_transaction)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "balance_transaction"} | _] = bt}} = env) do
    Enum.map(bt, fn transaction -> struct(BalanceTransaction, transaction) end)
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

  defp to_struct(%Env{body: %{object: "payout"} = payout} = env) do
    struct(Payout, payout)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "payout"} | _] = payouts}} = env) do
    Enum.map(payouts, fn payout -> struct(Payout, payout) end)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "refund"} | _] = refunds}} = env) do
    Enum.map(refunds, fn refund -> struct(Refund, refund) end)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{object: "refund"} = refund} = env) do
    struct(Refund, refund)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{object: "token"} = token} = env) do
    struct(Token, token)
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

  defp to_struct(%Env{body: %{token_type: "bearer"} = oauth_grant} = env) do
    struct(Connect, oauth_grant)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{object: "account"} = account} = env) do
    struct(Account, account)
    |> replace_body(env)
  end

  defp to_struct(%Env{body: %{data: [%{object: "account"} | _] = accounts}} = env) do
    Enum.map(accounts, fn account -> struct(Account, account) end)
    |> replace_body(env)
  end

  defp to_struct(any), do: any

  defp replace_body(struct, env) do
    raw_body = env.body
    new_opts = Keyword.put(env.opts, :raw_body, raw_body)

    %{env | body: struct, opts: new_opts}
  end
end
