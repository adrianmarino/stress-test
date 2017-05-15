alias Polcom.{Policy, OperatingBasisCache}
alias Polcom.Policy.Modifiers

defmodule Polcom.AssociationResolver do
  def operating_basis(policy), do: OperatingBasisCache.get(basis_id_from(policy))

  defp basis_id_from(policy) do
    modifiers = Policy.modifiers(policy)
    Modifiers.operating_basis_id(modifiers)
  end
end
