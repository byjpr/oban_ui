defmodule ObanUi.Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: ObanUi

      import Plug.Conn
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/oban_ui/templates",
        namespace: ObanUi

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
