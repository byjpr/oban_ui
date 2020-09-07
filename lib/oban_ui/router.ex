defmodule ObanUi.Router do
  defmacro oban_web(path) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        get("/", ObanUi.JobController, :show)
        get("/completed", ObanUi.JobController, :completed)
        delete("/:job_id", ObanUi.JobController, :delete)
      end
    end
  end
end
