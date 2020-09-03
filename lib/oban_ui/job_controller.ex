defmodule ObanUi.JobController do
  use ObanUi.Web, :controller

  def show(conn, params) do
    json(conn, %{name: Repo.all(ObanUi.Job)})
  end
end
