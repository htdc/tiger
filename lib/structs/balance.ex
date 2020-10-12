defmodule Tiger.Structs.Balance do
  @moduledoc """
  Struct representing Stripe Balance objects
  """
  @derive Jason.Encoder
  defstruct [
    :available,
    :pending,
    :object,
    :connect_reserved,
    :instant_available,
    :issuing,
    :livemode
  ]

  @type t :: %__MODULE__{
    available: [map()],
    pending: [map()],
    object: String.t(),
    connect_reserved: [map()],
    instant_available: [map()],
    issuing: map(),
    livemode: boolean()
  }
end
