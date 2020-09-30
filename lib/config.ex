defmodule Tiger.Config do
  @moduledoc """
  Struct for storing API keys
  """
  defstruct [:api_key]

  @type t :: %__MODULE__{
          api_key: String.t()
        }
end
