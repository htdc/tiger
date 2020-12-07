defmodule Tiger.MixProject do
  use Mix.Project

  def project do
    [
      app: :tiger,
      version: "0.1.0",
      elixir: "~> 1.10",
      description: "Elixir client for interacting with Stripe's API",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      docs: [
        extras: ["README.md"],
        assets: "assets"
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
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:idna, "~> 6.0"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.3.3"},
      {:gun, "~> 1.3.3"},
      {:nug, "~> 0.4", only: [:test]}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "test/support/test_helpers"]
  defp elixirc_paths(_), do: ["lib"]
end
