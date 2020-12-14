defmodule Tiger.Test do
  use ExUnit.Case
  doctest Tiger

  test "build account headers" do
    assert Tiger.account_header("abc123") == [headers: [{"stripe-account", "abc123"}]]
  end

  test "build query" do
    assert Tiger.query(type: "payment") == [query: [{:type, "payment"}]]
  end

  test "Combined options" do
    assert Tiger.connect_options("abc123") == [headers: [{"stripe-account", "abc123"}]]
  end

  test "Combined options with query" do
    assert Tiger.connect_options("abc123", type: "payment", limit: 3) == [
             headers: [{"stripe-account", "abc123"}],
             query: [type: "payment", limit: 3]
           ]
  end
end
