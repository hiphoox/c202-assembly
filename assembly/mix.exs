defmodule Assembly.MixProject do
  use Mix.Project

  def project do
    [
      app: :assembly,
      version: "0.1.0",
      escript: escript_config(),
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
      {:elixir_xml_to_map, "~> 0.1"}
    ]
  end

  defp escript_config do 
    [
      main_module: Assembly
    ]
  end
end
