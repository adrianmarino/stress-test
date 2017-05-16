defmodule Core.StringUtil do
  def to_atom(value) when is_atom(value), do: value
  def to_atom(value), do: String.to_atom(value)
  def to_float(value) do
    case String.contains?(value, ".") do
      true -> String.to_float(value)
      false -> String.to_integer(value)
    end
  end
end
