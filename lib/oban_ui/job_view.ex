defmodule ObanUi.JobView do
  use ObanUi.Web, :view

  @spec state_classes(<<_::72>>) :: <<_::184, _::_*32>>
  def state_classes(state) do
    case state do
      "available" -> "text-green-700 bg-green-100"
      "scheduled" -> "text-orange-700 bg-gray-100"
      "executing" -> "text-orange-700 bg-gray-100"
      "retryable" -> "text-orange-700 bg-gray-100"
      "completed" -> "text-green-700 bg-green-100"
      "cancelled" -> "text-red-700 bg-red-100"
      "discarded" -> "text-red-700 bg-red-100"
    end
  end
end
