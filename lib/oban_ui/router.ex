defmodule ObanUi.Router do
  defmacro oban_web(path) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        get("/", ObanUi.JobController, :show)
      end
    end
  end
end
