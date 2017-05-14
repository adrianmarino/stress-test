defmodule Core.Store do
  def create(name, value), do: Agent.start_link(fn -> value end, name: name)
  def get(name), do: Agent.get(name, fn value -> value end)
  def update(name, value), do: Agent.update(name, fn _old_value -> value end)
end
