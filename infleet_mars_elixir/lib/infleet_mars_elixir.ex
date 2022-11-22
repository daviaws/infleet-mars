defmodule InfleetMarsElixir do
  @moduledoc """
  InfleetMarsElixir keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def model_version(context, schema) do
    Application.get_env(:infleet_mars_elixir, :models_versions)[context][schema]
  end

  def enum(:direction), do: [N: 0, L: 1, S: 2, O: 3]
  def enum(:movement), do: [M: 0, D: 1, E: 2]
  def enum(_), do: nil
  def enum_keys(any), do: enum(any) |> keys()
  def enum_keys_string(any), do: enum_keys(any) |> keys_string()
  def enum_values(any), do: enum(any) |> values()

  defp keys(enum) when is_list(enum), do: Keyword.keys(enum)
  defp keys(_), do: nil

  @doc """
  Matches if string is subset from enum
  """
  def enum_string?(enum, string) when is_atom(enum) and is_bitstring(string) do
    case enum_keys_string(enum) do
      nil -> nil
      keys_string -> String.match?(string, ~r/^[#{keys_string}]+$/)
    end
  end

  defp keys_string(keys) when is_list(keys), do: Enum.join(keys)
  defp keys_string(_), do: nil

  defp values(enum) when is_list(enum), do: Keyword.values(enum)
  defp values(_), do: nil
end
