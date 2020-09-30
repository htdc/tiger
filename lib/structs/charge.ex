defmodule Tiger.Structs.Charge do
  @moduledoc """
  Struct representing a Stripe Charge object
  """
  @derive Jason.Encoder
  defstruct [
    :id,
    :object,
    :amount,
    :amount_captured,
    :amount_refunded,
    :application,
    :application_fee,
    :application_fee_amount,
    :balance_transaction,
    :billing_details,
    :calculated_statement_descriptor,
    :captured,
    :created,
    :currency,
    :customer,
    :description,
    :disputed,
    :failure_code,
    :failure_message,
    :fraud_details,
    :invoice,
    :livemode,
    :metadata,
    :on_behalf_of,
    :order,
    :outcome,
    :paid,
    :payment_intent,
    :payment_method,
    :payment_method_details,
    :receipt_email,
    :receipt_number,
    :receipt_url,
    :refunded,
    :refunds,
    :review,
    :shipping,
    :source_transfer,
    :statement_descriptor,
    :statement_descriptor_suffix,
    :status,
    :transfer,
    :transfer_data,
    :transfer_group
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          object: String.t(),
          amount: number(),
          amount_captured: number(),
          amount_refunded: number(),
          application: String.t() | nil,
          application_fee: String.t(),
          application_fee_amount: number(),
          balance_transaction: String.t(),
          billing_details: map | nil,
          calculated_statement_descriptor: String.t(),
          captured: boolean(),
          created: number(),
          currency: String.t(),
          customer: map | nil,
          description: String.t(),
          disputed: boolean(),
          failure_code: String.t(),
          failure_message: String.t(),
          fraud_details: map | nil,
          invoice: String.t(),
          livemode: boolean(),
          metadata: map | nil,
          on_behalf_of: String.t() | nil,
          order: String.t(),
          outcome: map,
          paid: boolean(),
          payment_intent: String.t(),
          payment_method: String.t(),
          payment_method_details: map | nil,
          receipt_email: String.t(),
          receipt_number: String.t(),
          receipt_url: String.t(),
          refunded: boolean(),
          refunds: map | nil,
          review: String.t(),
          shipping: map | nil,
          source_transfer: String.t() | nil,
          statement_descriptor: String.t() | nil,
          statement_descriptor_suffix: String.t() | nil,
          status: String.t(),
          transfer: String.t(),
          transfer_data: map | nil,
          transfer_group: String.t()
        }
end
