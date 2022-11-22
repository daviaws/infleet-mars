defmodule InfleetMarsElixir.Random do
  @moduledoc """
  The Random methods context.
  """
  def pick(array) when is_list(array) do
    index = :rand.uniform(length(array)) - 1

    array
    |> Enum.with_index()
    |> Enum.into(%{}, & &1)
    |> Map.get(index)
  end

  def pick(_), do: nil
end
