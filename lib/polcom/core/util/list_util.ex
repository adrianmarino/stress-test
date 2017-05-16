defmodule Core.ListUtil do
  def intersection(list_a, list_b) do
    listc = list_a -- list_b
    list_a -- listc
  end
end
