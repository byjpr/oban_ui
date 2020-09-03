defmodule ObanUi.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "oban_jobs" do
    field(:queue, :string)
    # field(:state, :oban_job_state)
  end
end
