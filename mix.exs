defmodule BRAN.MixProject do
  use Mix.Project

  def project do
    [
      app: :bran_checker,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.circle": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      description: description(),
      package: package(),
      source_url: "https://github.com/Xerpa/bran"
    ]
  end

  defp description() do
    "Elixir package to validate bank account numbers of Brazilian banks."
  end

  defp package() do
    [
      name: "BRAN Checker",
      links: %{"GitHub" => "https://github.com/Xerpa/bran"},
      licenses: ["MIT"]
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
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:junit_formatter, "~> 3.1", only: :test, runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_parameterized, "~> 1.3", only: [:test]}
    ]
  end
end
