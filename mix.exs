defmodule Cubecto.MixProject do
  use Mix.Project

  def project do
    [
      app: :cubecto,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      source_url: source_url(),
      description: description(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, ">= 0.13.2"},
      {:ecto, ">= 2.1.0"},
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Postgrex.Extension and Ecto.Type for PostgreSQL cube module"
  end

  defp docs do
    [
      main: "readme",
      extras: extras()
    ]
  end

  defp extras do
    [
      "README.md"
    ]
  end

  defp source_url do
    "https://github.com/ibarchenkov/cubecto"
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()},
      maintainers: ["Igor Barchenkov"]
    ]
  end
end
