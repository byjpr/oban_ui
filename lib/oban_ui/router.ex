defmodule ObanUi.Router do
  defmacro oban_web(path) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        get("/", ObanUi.JobController, :index)
        delete("/:job_id", ObanUi.JobController, :delete)
        put("/:job_id", ObanUi.JobController, :update)
        get("/jobs/available", ObanUi.JobController, :available)
        get("/jobs/scheduled", ObanUi.JobController, :scheduled)
        get("/jobs/executing", ObanUi.JobController, :executing)
        get("/jobs/retryable", ObanUi.JobController, :retryable)
        get("/jobs/completed", ObanUi.JobController, :completed)
        get("/jobs/discarded", ObanUi.JobController, :discarded)
      end
    end
  end
end
