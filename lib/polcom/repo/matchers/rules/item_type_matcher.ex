alias Polcom.{Policy, Policy.Rules}

defmodule Polcom.ItemMatcher do
  def match?(nil, _), do: true
  def match?("", _), do: true
  def match?(value, policy) do
    case Policy.rules(policy) do
      nil -> false
      rules ->
        case Rules.item_types(rules) do
          [] -> false
          list -> Enum.member?(list, value)
        end
    end
  end
end
