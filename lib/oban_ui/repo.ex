defmodule ObanUi.Repo do
  defmacro __using__(_) do
    quote do
      alias unquote(Application.get_env(:oban_ui, :repo)), as: Repo
    end
  end
end
