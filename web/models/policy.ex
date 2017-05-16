import List, only: [wrap: 1]
import Polcom.FieldUtil

defmodule Polcom.Policy do
  def expire_date(policy), do: policy["expire_date"]

  def site(policy), do: policy["site"]
  def brands(policy), do: wrap(policy["brands"])
  def channels(policy), do: wrap(policy["channels"])

  def rules(policy), do:  policy["rules"]
  def modifiers(policy), do:  policy["modifiers"]

  defmodule Rules do
    def product_types(rules), do: list_field(rules, "product_type")
    def item_types(rules), do: list_field(rules, "item_type")

    def airlines(rules), do: list_field(rules, "airline_code")
    def route_origins(rules), do: list_field(rules, "route_origin")
    def route_destinations(rules), do: list_field(rules, "route_destination")

    def departure_dates(rules), do: dates_field(list_field(rules, "departure_date"), "0000")
    def returning_dates(rules), do: dates_field(list_field(rules, "returning_date"), "9999")
    def periods(rules), do: Enum.zip(departure_dates(rules), returning_dates(rules))
  end

  defmodule Modifiers do
    def payment_type(modifiers), do: modifiers["payment_type"]
    def operating_basis_id(modifiers), do: to_string(modifiers["operating_basis_id"])

    def credit_card_id(modifiers), do: to_string(Map.get(modifiers, "credit_card_id", ""))
    def financial_entity_id(modifiers), do: to_string(Map.get(modifiers, "financial_entity_id", ""))
    def installments(modifiers), do: Map.get(modifiers, "installments", [])
  end
end
