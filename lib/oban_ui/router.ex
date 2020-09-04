defmodule ObanUi.Router do
  defmacro oban_web(path, opts \\ []) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        # opts = ObanUi.Router.__options__(opts)
        get("/", ObanUi.JobController, :show, opts)
      end
    end
  end
end
