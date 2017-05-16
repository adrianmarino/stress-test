alias Polcom.{Policy, Policy.Rules}

defmodule Polcom.AirlinesMatcher do
  def match?(nil, _), do: true
  def match?([], _), do: true
  def match?(airlines, policy) do
    case Policy.rules(policy) do
      nil   -> false
      rules ->
        case Rules.airlines(rules) do
          []   -> true
          list -> Enum.any?(airlines, &(Enum.member?(list, &1)))
        end
    end
  end
end
