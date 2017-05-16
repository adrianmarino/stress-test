alias Polcom.{Policy, Policy.Modifiers, Policy.Rules}
import Polcom.AssociationResolver, only: [operating_basis: 1]
import Enum, only: [map: 2, sort: 2]
import List, only: [flatten: 1]
import String, only: [to_integer: 1]
import Core.ListUtil, only: [intersection: 2]

defmodule Polcom.PolicyToCreditCardOperatingfCostConverter do
    def convert(policies, flight), do: policies
      |> map(&(to_destiny(operating_basis(&1), &1, flight)))
      |> flatten
      |> MapSet.new
      |> sort(&(&1.percent >= &2.percent))

    defp to_destiny(basis, policy, flight) do
      modifiers = Policy.modifiers(policy)
      rules = Policy.rules(policy)

      financial_entity_id = to_int_or_nil(Modifiers.financial_entity_id(modifiers))
      credit_card_id = to_integer(Modifiers.credit_card_id(modifiers))
      airlines = resolve_airlines(flight, rules);

      Modifiers.installments(modifiers)
        |> map(fn(installments)-> airlines |> map(fn airline->
                  %{
                    airline: airline,
                    credit_card_id: credit_card_id,
                    financial_entity_id: financial_entity_id,
                    installments: to_integer(installments),
                    percent: fetch_installments(basis, installments)
                  }
               end)
          end)
    end

    defp fetch_installments(basis, value), do: Map.get(basis, value, 1)

    defp to_int_or_nil(""), do: nil
    defp to_int_or_nil(value), do: to_integer(value)

    defp resolve_airlines(flight, rules) do
      case Rules.airlines(rules) do
        [] -> flight.airlines
        _ -> intersection(flight.airlines, Rules.airlines(rules))
      end
    end
end
