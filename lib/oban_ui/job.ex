defmodule ObanUi.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "oban_jobs" do
    field(:state, :string)
    field(:queue, :string)
    field(:worker, :string)
    field(:args, :map)
    field(:errors, {:array, :map})
    field(:attempt, :integer)
    field(:inserted_at, :utc_datetime)
    field(:scheduled_at, :utc_datetime)
    field(:attempted_at, :utc_datetime)
    field(:completed_at, :utc_datetime)
    field(:attempted_by, {:array, :string})
    field(:discarded_at, :utc_datetime)
    field(:priority, :integer)
    field(:tags, {:array, :string})
  end

  def changeset(oban_job, attrs), do: oban_job |> cast(attrs, [:state])
end
