defmodule Polcom.FieldUtil do
  def list_field(rules, name) do
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

  def dates_field(value, if_none) do
    case value do
      nil -> [if_none]
      [] -> [if_none]
      _ -> String.split(List.first(value), "|")
    end
  end
end
