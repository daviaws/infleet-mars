defmodule InfleetMarsElixir.Movement do
  @moduledoc """
  The Movement context.
  """

  import Ecto.Query, warn: false
  alias InfleetMarsElixir.Repo

  alias InfleetMarsElixir.Movement.MovementStatus

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

  alias InfleetMarsElixir.Movement.Movements

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
end
