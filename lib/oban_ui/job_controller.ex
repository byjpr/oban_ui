defmodule ObanUi.JobController do
  use ObanUi.Web, :controller

  def show(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def delete(conn, %{"job_id" => id}) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    repo.get(ObanUi.Job, id) |> repo.delete()

    redirect(conn,
      to: :"#{Application.get_env(:oban_ui, :app_name)}.Router.Helpers".job_path(conn, :show)
    )
  end

  def available(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs =
      Ecto.Query.from(j in ObanUi.Job, where: j.state == "completed")
      |> repo.all(ObanUi.Job)

    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def scheduled(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def executing(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def retryable(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def completed(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs =
      Ecto.Query.from(j in ObanUi.Job, where: j.state == "completed")
      |> repo.all(ObanUi.Job)

    render(conn, "show.html", oban_jobs: oban_jobs)
  end

  def discarded(conn, _params) do
    {Ecto, repo} = Application.get_env(:oban_ui, :connection)

    oban_jobs = repo.all(ObanUi.Job)
    render(conn, "show.html", oban_jobs: oban_jobs)
  end
end
