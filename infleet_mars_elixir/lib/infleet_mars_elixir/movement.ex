defmodule InfleetMarsElixir.Movement do
  @moduledoc """
  The Movement context.
  """

  import Ecto.Query, warn: false
  alias InfleetMarsElixir.Repo

  alias InfleetMarsElixir.Movement.Movables
  alias InfleetMarsElixir.Movement.Movements
  alias InfleetMarsElixir.Movement.MovementStatus

  def set_world(x, y) do
    world = %{x: x, y: y}
    Application.put_env(:infleet_mars_elixir, :world, world)
    {:ok, world}
  end

  def world() do
    Application.get_env(:infleet_mars_elixir, :world)
  end

  def format(%Movables{} = movable) do
    "#{movable.x} #{movable.y} #{movable.direction}"
  end

  def move(%Movables{} = movable, %Movements{} = movement) do
    %{x: max_x, y: max_y} = world()

    # fixed definitions
    directions = InfleetMarsElixir.enum(:direction)
    limit = length(directions)

    Enum.reduce(String.graphemes(movement.terminals), movable, fn movement, movable ->
      case movement do
        "E" ->
          # to turn left: enum - 1
          new_direction = Keyword.get(directions, movable.direction) - 1
          # fix overflow
          new_direction =
            if new_direction < 0 do
              limit - 1
            else
              new_direction
            end

          change_movables(movable, %{direction: new_direction}) |> Repo.update!()

        "D" ->
          # to turn right: enum + 1, fix overflow
          new_direction = rem(Keyword.get(directions, movable.direction) + 1, limit)

          change_movables(movable, %{direction: new_direction}) |> Repo.update!()

        "M" ->
          case movable.direction do
            :L ->
              new_x = rem(movable.x + 1, max_x + 1)
              change_movables(movable, %{x: new_x}) |> Repo.update!()

            :N ->
              new_y = rem(movable.y + 1, max_y + 1)
              change_movables(movable, %{y: new_y}) |> Repo.update!()

            :O ->
              new_x = movable.x - 1
              # fix overflow
              new_x =
                if new_x < 0 do
                  max_x
                else
                  new_x
                end

              change_movables(movable, %{x: new_x}) |> Repo.update!()

            :S ->
              new_y = movable.y - 1
              # fix overflow
              new_y =
                if new_y < 0 do
                  max_y
                else
                  new_y
                end

              change_movables(movable, %{y: new_y}) |> Repo.update!()
          end
      end
    end)
  end

  @doc """
  Returns the list of movements_statuses.

  ## Examples

      iex> list_movements_statuses()
      [%MovementStatus{}, ...]

  """
  def list_movements_statuses do
    Repo.all(MovementStatus)
  end

  @doc """
  Gets a single movement_status.

  Raises `Ecto.NoResultsError` if the Movement status does not exist.

  ## Examples

      iex> get_movement_status!(123)
      %MovementStatus{}

      iex> get_movement_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movement_status!(id), do: Repo.get!(MovementStatus, id)

  @doc """
  Creates a movement_status.

  ## Examples

      iex> create_movement_status(%{field: value})
      {:ok, %MovementStatus{}}

      iex> create_movement_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movement_status(attrs \\ %{}) do
    %MovementStatus{}
    |> MovementStatus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movement_status.

  ## Examples

      iex> update_movement_status(movement_status, %{field: new_value})
      {:ok, %MovementStatus{}}

      iex> update_movement_status(movement_status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movement_status(%MovementStatus{} = movement_status, attrs) do
    movement_status
    |> MovementStatus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movement_status.

  ## Examples

      iex> delete_movement_status(movement_status)
      {:ok, %MovementStatus{}}

      iex> delete_movement_status(movement_status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movement_status(%MovementStatus{} = movement_status) do
    Repo.delete(movement_status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movement_status changes.

  ## Examples

      iex> change_movement_status(movement_status)
      %Ecto.Changeset{data: %MovementStatus{}}

  """
  def change_movement_status(%MovementStatus{} = movement_status, attrs \\ %{}) do
    MovementStatus.changeset(movement_status, attrs)
  end

  @doc """
  Returns the list of movements.

  ## Examples

      iex> list_movements()
      [%Movements{}, ...]

  """
  def list_movements do
    Repo.all(Movements)
  end

  @doc """
  Gets a single movements.

  Raises `Ecto.NoResultsError` if the Movements does not exist.

  ## Examples

      iex> get_movements!(123)
      %Movements{}

      iex> get_movements!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movements!(id), do: Repo.get!(Movements, id)

  @doc """
  Creates a movements.

  ## Examples

      iex> create_movements(%{field: value})
      {:ok, %Movements{}}

      iex> create_movements(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movements(attrs \\ %{}) do
    %Movements{}
    |> Movements.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movements.

  ## Examples

      iex> update_movements(movements, %{field: new_value})
      {:ok, %Movements{}}

      iex> update_movements(movements, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movements(%Movements{} = movements, attrs) do
    movements
    |> Movements.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movements.

  ## Examples

      iex> delete_movements(movements)
      {:ok, %Movements{}}

      iex> delete_movements(movements)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movements(%Movements{} = movements) do
    Repo.delete(movements)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movements changes.

  ## Examples

      iex> change_movements(movements)
      %Ecto.Changeset{data: %Movements{}}

  """
  def change_movements(%Movements{} = movements, attrs \\ %{}) do
    Movements.changeset(movements, attrs)
  end

  @doc """
  Returns the list of movables.

  ## Examples

      iex> list_movables()
      [%Movables{}, ...]

  """
  def list_movables do
    Repo.all(Movables)
  end

  @doc """
  Gets a single movables.

  Raises `Ecto.NoResultsError` if the Movables does not exist.

  ## Examples

      iex> get_movables!(123)
      %Movables{}

      iex> get_movables!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movables!(id), do: Repo.get!(Movables, id)

  @doc """
  Creates a movables.

  ## Examples

      iex> create_movables(%{field: value})
      {:ok, %Movables{}}

      iex> create_movables(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movables(attrs \\ %{}) do
    %Movables{}
    |> Movables.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movables.

  ## Examples

      iex> update_movables(movables, %{field: new_value})
      {:ok, %Movables{}}

      iex> update_movables(movables, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movables(%Movables{} = movables, attrs) do
    movables
    |> Movables.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movables.

  ## Examples

      iex> delete_movables(movables)
      {:ok, %Movables{}}

      iex> delete_movables(movables)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movables(%Movables{} = movables) do
    Repo.delete(movables)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movables changes.

  ## Examples

      iex> change_movables(movables)
      %Ecto.Changeset{data: %Movables{}}

  """
  def change_movables(%Movables{} = movables, attrs \\ %{}) do
    Movables.changeset(movables, attrs)
  end
end
