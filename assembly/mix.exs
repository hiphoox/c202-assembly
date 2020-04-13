defmodule Assembly.MixProject do
  use Mix.Project

  def project do
    [
      app: :exc,
      version: "0.2.0",
      escript: escript_config(),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(), 
      name: "ExC",
      source_url: "https://github.com/hiphoox/c202-assembly"
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
      {:elixir_xml_to_map, "~> 0.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    ]
  end

  defp escript_config do 
    [
      main_module: ExC
    ]
  end
end