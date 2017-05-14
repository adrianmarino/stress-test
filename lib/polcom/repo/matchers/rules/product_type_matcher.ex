alias Polcom.Policy
alias Polcom.Policy.Rules

defmodule Polcom.ProductTypeMatcher do
  def match?(value, policy) do
    case value do
      nil -> true
      "" -> true
      _ ->
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
end
