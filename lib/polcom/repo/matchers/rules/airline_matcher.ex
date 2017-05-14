alias Polcom.Policy
alias Polcom.Policy.Rules

defmodule Polcom.AirlineMatcher do
  def match?(airline, policy) do
    case airline do
      nil -> true
      "" -> true
      _ ->
        case Policy.rules(policy) do
          nil -> false
          rules ->
            case Rules.airlines(rules) do
              [] -> true
              list -> Enum.member?(list, airline)
            end
        end
    end
  end
end
