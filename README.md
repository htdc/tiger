# Tiger

Elixir client for interacting with Stripe

## Installation

```elixir
def deps do
  [
    {:tiger, "~> 0.1.0"}
  ]
end
```

## Configuration

Configuration is done per request

```elixir
config = %Tiger.Config{api_key: "my secret key"}
client = Tiger.Client.new(config)
```

## Usage

```elixir
{:ok, %Tesla.Env{body: response}} = Tiger.Balance.get(client)

IO.inspect(response)

%Tiger.Structs.Balance{
  available: [%{amount: 103007, currency: "aud", source_types: %{card: 103007}}],
  connect_reserved: [%{amount: 0, currency: "aud"}],
  instant_available: nil,
  issuing: nil,
  livemode: false,
  object: "balance",
  pending: [%{amount: -6, currency: "aud", source_types: %{card: -6}}]
}
```

## Testing

Please see the `test` folder for examples of how you can write tests when using `Tiger`.