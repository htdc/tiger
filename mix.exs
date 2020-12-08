defmodule Tiger.MixProject do
  use Mix.Project

  def project do
    [
      app: :tiger,
      version: "0.2.0",
      elixir: "~> 1.10",
      description: "Elixir client for interacting with Stripe's API",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      docs: [
        extras: ["README.md"],
        assets: "assets",
        main: "readme"
      ]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      maintainers: ["Martin Feckie"],
      links: %{
        Github: "https://github.com/htdc/tiger"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :castore, :gun, :idna]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:castore, "~> 0.1"},
      {:certifi, "~> 2.0"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:gun, "~> 1.3.3"},
      {:idna, "~> 6.0"},
      {:jason, "~> 1.2"},
      {:nug, "~> 0.4", only: [:test]},
      {:plug, "~> 1.0"},
      {:ssl_verify_fun, "~> 1.0"},
      {:tesla, "~> 1.3.3"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "test/support/test_helpers"]
  defp elixirc_paths(_), do: ["lib"]
end
