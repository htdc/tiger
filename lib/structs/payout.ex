defmodule Tiger.Structs.Payout do
  @moduledoc """
  A struct representing a Stripe Payout object
  """
  defstruct [
      :id,
      :object,
      :amount,
      :arrival_date,
      :automatic,
      :balance_transaction,
      :created,
      :currency,
      :description,
      :destination,
      :failure_balance_transaction,
      :failure_code,
      :failure_message,
      :livemode,
      :metadata,
      :method,
      :source_type,
      :statement_descriptor,
      :status,
      :type
  ]

  @type t :: %__MODULE__{
    id: String.t(),
    object: String.t(),
    amount: number(),
    arrival_date: number(),
    automatic: boolean(),
    balance_transaction: String.t(),
    created: number(),
    currency: String.t(),
    description: String.t() | nil,
    destination: String.t(),
    failure_balance_transaction: String.t() | nil,
    failure_code: String.t() | nil,
    failure_message: String.t() | nil,
    livemode: boolean(),
    metadata: map(),
    method: String.t(),
    source_type: String.t(),
    statement_descriptor: String.t() | nil,
    status: String.t(),
    type: String.t()
  }
end
