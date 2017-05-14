defmodule Polcom.Policy do
  def expire_date(policy), do: policy["expire_date"]

  def brands(policy) do
    case policy["brands"] do
      nil -> []
      list -> list
    end
  end
  def site(policy), do: policy["site"]
  def channels(policy) do
    case policy["channels"] do
      nil -> []
      list -> list
    end
  end
  def rules(policy), do:  policy["rules"]
  def modifiers(policy), do:  policy["modifiers"]

  defmodule Field do
    def list(rules, name) do
      case rules[name] do
        nil -> []
        fields ->
          case List.first(fields) do
            nil -> []
            fields ->
              case fields["values"] do
                nil -> []
                values -> values
              end
          end
      end
    end
  end

  defmodule Rules do
    def product_types(rules), do: Field.list(rules, "product_type")
    def item_types(rules), do: Field.list(rules, "item_type")
    def airlines(rules), do: Field.list(rules, "airline_code")
    def route_origins(rules), do: Field.list(rules, "route_origin")
    def route_destinations(rules), do: Field.list(rules, "route_destination")
    def periods(rules), do: Enum.zip(departure_dates(rules), returning_dates(rules))

    defp departure_dates(rules), do: dates(Field.list(rules, "departure_date"), "0000")
    defp returning_dates(rules), do: dates(Field.list(rules, "returning_date"), "9999")
    defp dates(value, if_none) do
      case value do
        nil -> [if_none]
        [] -> [if_none]
        _ -> String.split(List.first(value), "|")
      end
    end
  end

  defmodule Modifiers do
    def payment_type(modifiers), do: modifiers["payment_type"]
    def operating_basis_id(modifiers), do: modifiers["operating_basis_id"]
  end
end
