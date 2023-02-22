defmodule Romeo.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :romeo,
      name: "Romeo",
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      applications: [:logger, :connection, :fast_xml, :ssl, :eex] ++ maybe_load_test_applications(Mix.env()),
      mod: {Romeo, []}
    ]
  end

  defp description do
    "An XMPP Client for Elixir"
  end

  defp deps do
    [
      {:connection, "~> 1.0"},
      {:fast_xml, "~> 1.1"},

      # Docs deps
      {:ex_doc, "~> 0.18", only: :dev},

      # Test deps
      {:ejabberd, "~> 21.7", only: :test},
      {:mock, "~> 0.3.1", only: :test},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end

  defp docs do
    [extras: docs_extras(), main: "readme"]
  end

  defp docs_extras do
    ["README.md"]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Sonny Scroggin"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/scrogson/romeo"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp maybe_load_test_applications(:test), do: [:ejabberd]
  defp maybe_load_test_applications(_), do: []
end
