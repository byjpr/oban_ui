defmodule ObanUi.MixProject do
  use Mix.Project

  def project do
    [
      app: :oban_ui,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
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
      {:phoenix, "~>1.5.8"},
      {:phoenix_html, "3.1.0"},
      {:gettext, "~> 0.11"},
      {:phoenix_ecto, "~> 4.1"}
    ]
  end
end
