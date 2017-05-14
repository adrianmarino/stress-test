use Timex
import Core.TimeUtil, only: [msec_humanized: 1]

defmodule Core do

  defmodule Time do
    defstruct [:value, :unit]
    def create(value), do: %Time{value: value, unit: :millis}

    defimpl String.Chars do
      def to_string(time), do: msec_humanized(time.value)
    end
  end

  defmodule Result do
    defstruct [:function, :return, :time]

    defimpl String.Chars do
      def to_string(result), do: "Time: #{result.time}"
    end
  end

  defmodule Profiler do
    def time(function) do
      start_time = Duration.now()
      return = function.()
      create_result(function, return, start_time, Duration.now)
    end

    defp create_result(function, return, start_time, end_time) do
      %Result{
        function: function,
        time: Time.create(Duration.diff(end_time, start_time, :microseconds)),
        return: return
      }
    end
  end
end
