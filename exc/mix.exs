defmodule Assembly.MixProject do
  use Mix.Project

  def project do
    [
      app: :exc,
      version: "0.2.1",
      escript: escript_config(),
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(), 
      name: "ExC",
      source_url: "https://github.com/hiphoox/c202-assembly",
      description: description(),
      package: package()
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

  defp description do 
      """
      C compiler built with Elixir. This library will only allow you to compile basic C programs. 
      """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hiphoox/c202-assembly"}
    ]
  end
end
