alias Polcom.Policy
alias Polcom.Policy.Modifiers
import Polcom.AssociationResolver, only: [operating_basis: 1]
import Enum, only: [map: 2, filter: 2, empty?: 1]
import List, only: [flatten: 1]
import String, only: [to_integer: 1]

defmodule Polcom.PolicyToCreditCardOperatinfCostConverter do
    def convert(policies, airline), do: policies
      |> map(&(to_destiny(operating_basis(&1), &1, airline)))
      |> flatten
      |> filter(&(not empty?(&1)))

    defp to_destiny(basis, policy, airline) do
      modifiers = Policy.modifiers(policy)
      bank_id = Modifiers.financial_entity_id(modifiers)
      credit_card_id = Modifiers.credit_card_id(modifiers)

      Modifiers.installments(modifiers) |> map(fn(installments)->
        %{
          airline: airline,
          credit_card_id: credit_card_id,
          financial_entity_id: bank_id,
          installments: installments,
          percent: Map.get(basis, to_integer(installments), 1)
        }
      end)
    end
end
