defmodule Tiger.Structs.BalanceTransaction do
  @moduledoc """
  Struct representing a Stripe BalanceTransaction object
  """
  @derive Jason.Encoder
  defstruct [
    :id,
    :object,
    :amount,
    :available_on,
    :created,
    :currency,
    :description,
    :exchange_rate,
    :fee,
    :fee_details,
    :net,
    :reporting_category,
    :source,
    :status,
    :type
  ]

  @type t :: %__MODULE__{
    id:  String.t(),
    object: String.t() ,
    amount: number() ,
    available_on: number(),
    created: number,
    currency: String.t(),
    description: String.t(),
    exchange_rate: number(),
    fee: number(),
    fee_details: [map()],
    net: number(),
    reporting_category: String.t(),
    source: String.t(),
    status: String.t(),
    type: String.t(),
  }
end
