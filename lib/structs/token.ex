defmodule Tiger.Structs.Token do
  @moduledoc """
  Struct to represent a Stripe Token object
  """

  @derive [FormSafe, Jason.Encoder]
  defstruct [
    :id,
    :object,
    :card,
    :client_ip,
    :created,
    :livemode,
    :type,
    :used
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          object: String.t(),
          card: map(),
          client_ip: String.t() | nil,
          created: number(),
          livemode: boolean(),
          type: String.t(),
          used: boolean()
        }
end
