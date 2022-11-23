defmodule InfleetMarsElixir.Task.Files do
  @moduledoc """
  The Task methods context for files.
  """

  alias InfleetMarsElixir.Movement

  def exec_sample() do
    exec_from_fixture("priv/fixtures/sample")
  end

  def exec_from_fixture(path) do
    File.stream!(path)
    |> Stream.with_index()
    |> Stream.scan(fn {line, index}, acc ->
      index = index + 1
      IO.puts("#{index} #{line}")
      clean = String.slice(line, 0..-2)

      case index do
        1 = _world ->
          [x, y] = String.split(clean) |> Enum.map(&String.to_integer/1)
          Movement.set_world(x, y)

        _even = _movables when rem(index, 2) == 0 ->
          [x, y, d] = String.split(clean)

          {:ok, movable} =
            Movement.create_movables(%{
              x: String.to_integer(x),
              y: String.to_integer(y),
              direction: d
            })

          movable

        _odd = _movements when rem(index, 2) == 1 ->
          movables = acc

          {:ok, movement} =
            Movement.create_movements(%{terminals: clean, movables: Map.from_struct(movables)})

          result = Movement.move(movables, movement)
          IO.puts("Results: #{Movement.format(result)}")
      end
    end)
    |> Stream.run()
  end
end
