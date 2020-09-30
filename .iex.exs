alias Tiger.{Client, Config}
config = %Config{api_key: System.get_env("STRIPE_TEST_API_KEY")}

client = Tiger.Client.new(config)
