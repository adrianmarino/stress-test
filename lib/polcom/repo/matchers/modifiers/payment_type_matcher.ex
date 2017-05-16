alias Polcom.{Policy, Policy.Modifiers}

defmodule Polcom.PaymentTypeMatcher do
  def match?(nil, _), do: true
  def match?("", _), do: true
  def match?(value, policy) do
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
