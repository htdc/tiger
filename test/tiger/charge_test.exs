defmodule Tiger.ChargeTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.{CreateCharge, Charge}

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can make a charge" do
    with_proxy("create_charge.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.create(client, %CreateCharge{
          amount: 2000,
          source: "tok_au"
        })

      assert charge.id =~ ~r/ch_/
      assert charge.captured
    end
  end

  test "Can make a charge with Connect" do
    with_proxy("create_charge_connect.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.create(client, %CreateCharge{
          amount: 2000,
          source: "tok_au",
          application_fee: 250,
          transfer_data: %{
            destination: "acct_1HSZKXFFwAeTesFQ"
          }
        })

      assert charge.transfer.destination == "acct_1HSZKXFFwAeTesFQ"
      assert charge.transfer.destination_payment =~ ~r/py_/
      assert charge.transfer.amount == 2000
      assert charge.application_fee_amount == 250
    end
  end

  test "Can make a pre-auth charge" do
    with_proxy("create_charge_pre_auth.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.create(client, %CreateCharge{
          amount: 2000,
          source: "tok_au",
          capture: false
        })

      assert charge.id =~ ~r/ch_/
      refute charge.captured
    end
  end

  test "Can retrieve a charge" do
    with_proxy("get_charge.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.get(client, "ch_1HYr2GClStGc5XwOogX26olX")

      assert charge.id == "ch_1HYr2GClStGc5XwOogX26olX"
      assert charge.captured
    end
  end

  test "Can retrieve a charge and expand" do
    with_proxy("get_charge-expand.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.get(client, "ch_1HYr2GClStGc5XwOogX26olX", query: [expand: ["transfer"]])

      assert charge.id == "ch_1HYr2GClStGc5XwOogX26olX"
      assert charge.captured
      assert charge.transfer.destination_payment == "py_1HYr2GFFwAeTesFQ97LlDWPW"
    end
  end

  test "Can make a update a charge" do
    with_proxy("update_charge.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.update(client, "ch_1HYr2FClStGc5XwOTkbd7AuG", %{description: "I am updated"})

      assert charge.description == "I am updated"
    end
  end

  test "Can retrieve a list of charges" do
    with_proxy("list_charges.fixture") do
      {:ok, %Tesla.Env{body: charges}} = Tiger.Charge.list(client)
      [%Charge{} = first | _] = charges

      assert first.amount == 2000
      assert length(charges) == 10
    end
  end

  test "Can retrieve a list of charges with query parameters" do
    with_proxy("list_charges_with_query.fixture") do
      {:ok, %Tesla.Env{body: charges}} = Tiger.Charge.list(client, query: [limit: 100])

      assert length(charges) == 100
    end
  end

  test "Can capture a pre-auth charge" do
    with_proxy("capture_charge.fixture") do
      {:ok, %Tesla.Env{body: %Charge{} = charge}} =
        Tiger.Charge.capture(client, "ch_1HYtDwClStGc5XwO8e1EAjzl")

      assert charge.id == "ch_1HYtDwClStGc5XwO8e1EAjzl"
      assert charge.id =~ ~r/ch_/
      assert charge.captured
    end
  end
end
