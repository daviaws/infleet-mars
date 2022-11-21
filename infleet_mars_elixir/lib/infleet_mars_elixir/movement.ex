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
end
