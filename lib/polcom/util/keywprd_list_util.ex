import Core.MapUtil, only: [sub_map: 2, to_keyword_list: 1]
import Enum, only: [into: 2]

defmodule Core.KeywordListUtil do
  def sub_list(list, keys), do: to_keyword_list(sub_map(into(list, %{}), keys))
end
