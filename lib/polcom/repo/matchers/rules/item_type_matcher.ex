alias Polcom.Policy
alias Polcom.Policy.Rules

defmodule Polcom.ItemMatcher do
  def match?(item_type, policy) do
    case item_type do
      nil -> true
      "" -> true
      _ ->
        case Policy.rules(policy) do
          nil -> false
          rules ->
            case Rules.item_types(rules) do
              [] -> false
              list -> Enum.member?(list, item_type)
            end
        end
    end
  end
end
