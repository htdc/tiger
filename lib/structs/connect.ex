defmodule Tiger.Structs.Connect do
  @moduledoc """
  Convenience Struct for showing a connect response
  """
  defstruct [
    :access_token,
    :livemode,
    :refresh_token,
    :scope,
    :stripe_publishable_key,
    :stripe_user_id,
    :token_type
  ]

  @type t :: %__MODULE__{
          access_token: String.t(),
          livemode: boolean(),
          refresh_token: String.t(),
          scope: String.t(),
          stripe_publishable_key: String.t(),
          stripe_user_id: String.t(),
          token_type: String.t()
        }
end
