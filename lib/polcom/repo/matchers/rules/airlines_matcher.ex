alias Polcom.Policy
alias Polcom.Policy.Rules

defmodule Polcom.AirlinesMatcher do
  def match?(airlines, policy) do
    case airlines do
      nil -> true
      []  -> true
      _   ->
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
end
