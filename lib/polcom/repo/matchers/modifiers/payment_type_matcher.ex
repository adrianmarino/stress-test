alias Polcom.Policy
alias Polcom.Policy.Modifiers

defmodule Polcom.PaymentTypeMatcher do
  def match?(value, policy) do
    case value do
      nil -> true
      "" -> true
      _ ->
        case Policy.modifiers(policy) do
          nil -> false
          modifiers ->
            case Modifiers.payment_type(modifiers) do
              [] -> false
              list -> Enum.member?(list, value)
            end
        end
      end
  end
end
