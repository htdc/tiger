defmodule Tiger.Structs.Refund do
  @moduledoc """
  Struct to represent a Stripe Refund object
  """

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transaction,
    :charge,
    :created,
    :currency,
    :description,
    :metadata,
    :payment_intent,
    :reason,
    :receipt_number,
    :source_transfer_reversal,
    :status,
    :transfer_reversal
  ]

  @type t :: %__MODULE__{
    id: String.t(),
    object: String.t(),
    amount: number(),
    balance_transaction: String.t(),
    charge: String.t(),
    created: number(),
    currency: String.t(),
    description: String.t(),
    metadata: map(),
    payment_intent: String.t() | nil,
    reason: String.t() | nil,
    source_transfer_reversal: String.t() | nil,
    status: String.t(),
    transfer_reversal: String.t() | nil
  }
end
