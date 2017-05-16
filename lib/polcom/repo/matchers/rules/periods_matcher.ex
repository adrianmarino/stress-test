alias Polcom.{Policy, Policy.Rules}
import Enum, only: [any?: 2]

defmodule Polcom.PeriodMatcher do
  def match?(nil, _, _), do: true
  def match?("", _, _), do: true
  def match?(_, nil, _), do: true
  def match?(_, "", _), do: true
  def match?(from, to, policy) do
    case Policy.rules(policy) do
      nil -> false
      rules -> Rules.periods(rules) |> any?(&(between?(&1, from, to)))
    end
  end

  defp between?(period, from, to) do
    period_from = elem(period, 0)
    period_to = elem(period, 1)

    from = add_time(from)
    to = add_time(to)

    period_from <= to && from <= period_to
  end

  defp add_time(value), do: "#{value}T00:00"
end
