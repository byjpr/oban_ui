defmodule ObanUi.JobController do
  use ObanUi.Web, :controller

  def show(conn, params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end
end
