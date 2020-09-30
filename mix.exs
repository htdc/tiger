defmodule Tiger.MixProject do
  use Mix.Project

  def project do
    [
      app: :tiger,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:nug, "~> 0.4"}
    ]
  end
end
