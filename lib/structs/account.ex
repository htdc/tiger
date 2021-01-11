defmodule Tiger.Structs.Account do
  defstruct [
    :id,
    :business_type,
    :capabilities,
    :company,
    :country,
    :email,
    :individual,
    :metadata,
    :requirements,
    :tos_acceptance,
    :type,
    :object,
    :business_profile,
    :charges_enabled,
    :created,
    :default_currency,
    :details_submitted,
    :external_accounts,
    :payouts_enabled,
    :setting
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          business_type: String.t(),
          capabilities: map(),
          company: map(),
          country: String.t(),
          email: String.t(),
          individual: map(),
          metadata: map(),
          requirements: map(),
          tos_acceptance: map(),
          type: String.t(),
          object: String.t(),
          business_profile: map(),
          charges_enabled: boolean(),
          created: String.t(),
          default_currency: String.t(),
          details_submitted: boolean(),
          external_accounts: [map()],
          payouts_enabled: boolean(),
          setting: map()
        }
end
