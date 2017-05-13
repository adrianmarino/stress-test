defmodule Core.JSON do
  def to_struct(json) do
    case JSX.decode(json) do
      {:ok, struct} -> struct
      {:error, message} -> message
    end
  end

  def to_pretty_json(map) do
    case map |> JSX.encode do
      {:ok, json} -> prettify(json)
      {:error, message} -> message
    end
  end

  def to_json(map) do
    case map |> JSX.encode do
      {:ok, json} -> json
      {:error, message} -> message
    end
  end

  defp prettify(json) do
    cond do
      String.length(json) <= 80 -> json
      true ->
        case JSX.prettify(json) do
          {:ok, json } -> json
          {:error, message} -> message
        end
    end
  end
end
