defmodule Tiger.Structs.CreateCharge do
  @moduledoc """
  Convenience Struct for use when creating charges.

  Exists to prevent using maps with missing keys
  """

  @enforce_keys [:amount]
  @derive [Jason.Encoder, FormSafe]
  defstruct [
    :amount,
    :application_fee,
    :description,
    :metadata,
    :on_behalf_of,
    :receipt_email,
    :shipping,
    :source,
    :statement_descriptor_suffix,
    :statement_descriptor,
    :transfer_data,
    :transfer_group,
    capture: true,
    currency: "aud",
    expand: ["transfer"]
  ]

  @type t :: %__MODULE__{
          amount: integer(),
          application_fee: integer() | nil,
          capture: boolean() | nil,
          description: String.t(),
          metadata: map() | nil,
          on_behalf_of: String.t() | nil,
          receipt_email: String.t() | nil,
          shipping: map() | nil,
          source: String.t(),
          statement_descriptor_suffix: String.t() | nil,
          statement_descriptor: String.t() | nil,
          transfer_data: map() | nil,
          transfer_group: String.t() | nil,
          currency: String.t(),
          expand: list(String.t())
        }
end
