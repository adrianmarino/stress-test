alias Polcom.{Policy, Policy.Rules}

defmodule Polcom.ProductTypeMatcher do
  def match?(nil, _), do: true
  def match?("", _), do: true
  def match?(value, policy) do
    case Policy.rules(policy) do
      nil -> false
      rules ->
        case Rules.product_types(rules) do
          [] -> true
          list -> Enum.member?(list, value)
        end
    end
  end
end
