defmodule Core.TimeUtil do
  use Timex
  def humanize(duration), do: duration |> Timex.format_duration(:humanized)
  def sec_humanized(value), do: humanize(Duration.from_seconds(value))
  def msec_humanized(value), do: humanize(Duration.from_microseconds(value))
  def is(left, greater_or_equal_that:  right), do: Timex.compare(left, right) >= 0
end
