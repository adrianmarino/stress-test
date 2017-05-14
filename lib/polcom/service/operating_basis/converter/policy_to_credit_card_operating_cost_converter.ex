alias Polcom.Policy
alias Polcom.Policy.Modifiers
import Polcom.AssociationResolver, only: [operating_basis: 1]

defmodule Polcom.PolicyToCreditCardOperatinfCostConverter do
    def convert(policies, airline) do
      policies |> Enum.map(
        fn(policy)->
          basis = operating_basis(policy)
          modifiers = Policy.modifiers(policy)
          bank_id = Modifiers.financial_entity_id(modifiers)
          credit_card_id = Modifiers.credit_card_id(modifiers)

          Map.keys(basis) |> Enum.map(fn(installments)->
            %{
              airline: airline,
              credit_card_id: credit_card_id,
              financial_entity_id: bank_id,
              installments: installments,
              percent: basis[installments]
            }
          end)
        end
      )|> List.flatten
    end
end
