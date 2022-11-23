defmodule InfleetMarsElixir.Task do
  @moduledoc """
  The Task methods context.
  """
  alias InfleetMarsElixir.Task.Files

  defdelegate exec_sample, to: Files
  defdelegate exec_from_fixture(path), to: Files
end
