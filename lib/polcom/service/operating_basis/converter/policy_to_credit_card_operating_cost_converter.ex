alias Polcom.Policy
alias Polcom.Policy.Modifiers
alias Polcom.Policy.Rules
import Polcom.AssociationResolver, only: [operating_basis: 1]
import Enum, only: [map: 2, reject: 2, empty?: 1, sort: 2]
import List, only: [flatten: 1]
import String, only: [to_integer: 1]

defmodule Polcom.PolicyToCreditCardOperatinfCostConverter do
    def convert(policies), do: policies
      |> map(&(to_destiny(operating_basis(&1), &1)))
      |> flatten
      |> reject(&empty?/1)
      |> MapSet.new
      |> sort(&(&1.percent >= &2.percent))

    defp to_destiny(basis, policy) do
      modifiers = Policy.modifiers(policy)
      rules = Policy.rules(policy)

      bank_id = Modifiers.financial_entity_id(modifiers)
      credit_card_id = Modifiers.credit_card_id(modifiers)
      airlines = Rules.airlines(rules)

      Modifiers.installments(modifiers)
        |> map(fn(installments)-> airlines |> map(fn airline->
                  %{
                    airlines: airline,
                    credit_card_id: credit_card_id,
                    financial_entity_id: bank_id,
                    installments: installments,
                    percent: fetch_installments(basis, installments)
                  }
               end)
          end)
      |> flatten
    end

    defp fetch_installments(basis, value), do: Map.get(basis, to_integer(value), 1)
end
