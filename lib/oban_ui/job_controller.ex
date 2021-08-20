defmodule ObanUi.JobController do
  use ObanUi.Web, :controller
  use ObanUi.Repo
  import Ecto.Query, warn: false

  def index(conn, _params) do
    oban_jobs = Oban.Job |> order_by(desc: :id) |> Repo.all()
    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"job_id" => job_id}) do
    Repo.get(Oban.Job, job_id)
    |> ObanUi.Job.changeset(%{"state" => "discarded"})
    |> Repo.update()

    redirect(conn,
      to: :"#{Application.get_env(:oban_ui, :app_name)}.Router.Helpers".job_path(conn, :index)
    )
  end

  def delete(conn, %{"job_id" => id}) do
    Repo.get(ObanUi.Job, id) |> Repo.delete()

    redirect(conn,
      to: :"#{Application.get_env(:oban_ui, :app_name)}.Router.Helpers".job_path(conn, :index)
    )
  end

  def available(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "available")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  def scheduled(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "scheduled")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  def executing(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "executing")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  def retryable(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "retryable")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  def completed(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "completed")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end

  def discarded(conn, _params) do
    oban_jobs =
      from(j in Oban.Job, where: j.state == "discarded")
      |> Repo.all()

    render(conn, "index.html", oban_jobs: oban_jobs)
  end
end
