defmodule Tiger.AccountTest do
  use ExUnit.Case, async: true
  alias Tiger.Client
  alias Tiger.Structs.Account

  use Nug,
    upstream_url: Client.default_url(),
    client_builder: &TestClient.setup/1

  test "Can create a custom account" do
    with_proxy("account-custom-create.fixture") do
      account_details = %{
        type: "custom",
        country: "AU",
        email: "a@b.com",
        capabilities: %{
          card_payments: %{
            requested: true
          },
          transfers: %{
            requested: true
          }
        }
      }

      {:ok, %Tesla.Env{body: %Account{} = account}} =
        Tiger.Account.create(client, account_details)

      assert account.email == account_details.email
      assert account.id == "acct_1I8MDs2Rv0OlFwFe"
    end
  end

  test "Can create a standard account" do
    with_proxy("account-standard-create.fixture") do
      account_details = %{
        type: "standard",
        business_type: "individual",
        individual: %{
          address: %{
            line1: "address_full_match​"
          }
        },
        country: "AU",
        email: "a@b.com",
        external_account: %{
          object: "bank_account",
          country: "AU",
          currency: "AUD",
          routing_number: "110000",
          account_number: "000123456"
        }
      }

      {:ok, %Tesla.Env{body: %Account{} = account}} =
        Tiger.Account.create(client, account_details)

      assert account.email == account_details.email
      assert account.id == "acct_1I8MTJFI7sxT2oxI"
    end
  end

  test "Can create a verified custom account" do
    with_proxy("account-custom-verified.fixture") do
      account_details = %{
        type: "custom",
        business_type: "individual",
        company: %{
          address: %{
            line1: "address_full_match​",
            city: "Melbourne",
            state: "VIC",
            postal_code: "3000"
          }
        },
        individual: %{
          first_name: "Harry",
          last_name: "Potter",
          phone: "+61433123123",
          address: %{
            line1: "address_full_match​",
            city: "Melbourne",
            state: "VIC",
            postal_code: "3000"
          },
          email: "a@b.com",
          dob: %{
            day: "1",
            month: "1",
            year: "1901"
          },
          verification: %{
            document: %{
              front: "file_identity_document_success"
            }
          }
        },
        business_profile: %{
          url: "https://www.hotdoc.com.au",
          product_description: "Widgets"
        },
        tos_acceptance: %{
          date: DateTime.to_unix(DateTime.utc_now()),
          ip: "127.0.0.1"
        },
        country: "AU",
        email: "a@b.com",
        external_account: %{
          object: "bank_account",
          country: "AU",
          currency: "AUD",
          routing_number: "110000",
          account_number: "000123456"
        },
        capabilities: %{
          card_payments: %{
            requested: true
          },
          transfers: %{
            requested: true
          }
        }
      }

      {:ok, %Tesla.Env{body: %Account{} = account}} =
        Tiger.Account.create(client, account_details)

      assert account.email == account_details.email
      assert account.id == "acct_1I8NJH2RzhYwutv7"
    end
  end

  test "List connected accounts" do
    with_proxy("connect-list.fixture") do
      {:ok, %Tesla.Env{body: accounts}} = Tiger.Account.list(client)

      [%Account{} = first_account | _] = accounts

      assert first_account.email == "a@b.com"
      assert first_account.id == "acct_1I8N3y2QNhSQq2g6"
    end
  end

  test "Delete connected account" do
    with_proxy("connect-delete.fixture") do
      {:ok, %Tesla.Env{body: %Account{} = account }} = Tiger.Account.delete(client, "acct_1I8N3y2QNhSQq2g6")

      assert account.id == "acct_1I8N3y2QNhSQq2g6"
    end
  end
end
