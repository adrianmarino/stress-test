alias Polcom.{Policy, Policy.Modifiers, Policy.Rules}
import Polcom.AssociationResolver, only: [operating_basis: 1]
import Enum, only: [map: 2, sort: 2]
import List, only: [flatten: 1]
import String, only: [to_integer: 1]
import Core.StringUtil, only: [to_float: 1]

defmodule Polcom.PolicyToCreditCardOperatingfCostConverter do
    def convert(policies), do: policies
      |> map(&(to_destiny(operating_basis(&1), &1)))
      |> flatten
      |> MapSet.new
      |> sort(&(&1.percent >= &2.percent))

    defp to_destiny(basis, policy) do
      modifiers = Policy.modifiers(policy)
      rules = Policy.rules(policy)

      financial_entity_id = to_int_or_nil(Modifiers.financial_entity_id(modifiers))
      credit_card_id = to_integer(Modifiers.credit_card_id(modifiers))
      airlines = Rules.airlines(rules)

      Modifiers.installments(modifiers)
        |> map(fn(installments)-> airlines |> map(fn airline->
                  %{
                    airline: airline,
                    credit_card_id: credit_card_id,
                    financial_entity_id: financial_entity_id,
                    installments: to_integer(installments),
                    percent: to_float(fetch_installments(basis, installments))
                  }
               end)
          end)
    end

    defp fetch_installments(basis, value), do: Map.get(basis, to_integer(value), 1)

    defp to_int_or_nil(""), do: nil
    defp to_int_or_nil(value), do: to_integer(value)
end
