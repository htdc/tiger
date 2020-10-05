defmodule Tiger.Structs.Transfer do
  @moduledoc """
  Struct representing Transfers
  """

  @derive Jason.Encoder
  defstruct [
    :amount_reversed,
    :amount,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :destination_payment,
    :destination,
    :id,
    :livemode,
    :metadata,
    :object,
    :reversals,
    :reversed,
    :source_transaction,
    :source_type,
    :transfer_group
  ]


  @type t :: %__MODULE__{
    amount_reversed: integer() | nil,
    amount: integer() | nil,
    balance_transaction: String.t(),
    created: number(),
    currency: String.t(),
    description: String.t(),
    destination_payment: String.t() | nil,
    destination: String.t() | nil,
    id: String.t(),
    livemode: boolean(),
    metadata: map(),
    object: String.t(),
    reversals: map(),
    reversed: boolean(),
    source_transaction: String.t(),
    source_type: String.t(),
    transfer_group: String.t()
  }
end
