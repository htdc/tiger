defmodule Tiger.Charge do
  alias Tesla.Client
  alias Tiger.Structs.CreateCharge

  def create(%Client{} = client, %CreateCharge{} = params) do
    Tesla.post(client, "charges", FormSafe.encode(params))
  end

end
