defmodule ObanUi.MixProject do
  use Mix.Project

  def project do
    [
      app: :oban_ui,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      compilers: [:phoenix] ++ Mix.compilers(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :phoenix]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, ">= 1.3.0 and < 1.6.0"},
      {:phoenix_html, ">= 2.0.0 and <= 3.0.0"},
      {:ecto, "~> 2.2 or ~> 3.0"}
    ]
  end
end
