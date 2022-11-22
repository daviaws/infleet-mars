defmodule InfleetMarsElixir.MovementTest do
  use InfleetMarsElixir.DataCase

  alias InfleetMarsElixir.Movement

  import InfleetMarsElixir.Factory

  describe "movements_statuses" do
    alias InfleetMarsElixir.Movement.MovementStatus

    @invalid_required_attrs %{terminal: nil}

    test "list_movements_statuses/0 returns all movements_statuses" do
      movement_status = insert_list(2, :movement_status)
      assert Movement.list_movements_statuses() == movement_status
    end

    test "get_movement_status!/1 returns the movement_status with given id" do
      movement_status = insert(:movement_status)
      assert Movement.get_movement_status!(movement_status.id) == movement_status
    end

    test "create_movement_status/1 with valid data creates a movement_status" do
      valid_attrs = %{
        completed: true,
        end_direction:
          InfleetMarsElixir.enum_values(:direction) |> InfleetMarsElixir.Random.pick(),
        end_position_x: 42,
        end_position_y: 42,
        model_version: "some model_version",
        sent_at: ~N[2022-11-20 20:48:00],
        start_direction:
          InfleetMarsElixir.enum_values(:direction) |> InfleetMarsElixir.Random.pick(),
        start_position_x: 42,
        start_position_y: 42,
        status_code: 42,
        status_message: "some status_message",
        terminal: InfleetMarsElixir.enum_values(:movement) |> InfleetMarsElixir.Random.pick()
      }

      assert {:ok, %MovementStatus{} = movement_status} =
               Movement.create_movement_status(valid_attrs)

      assert movement_status.completed == true
      assert movement_status.end_direction in InfleetMarsElixir.enum_keys(:direction)
      assert movement_status.end_position_x == 42
      assert movement_status.end_position_y == 42
      assert movement_status.model_version == "some model_version"
      assert movement_status.sent_at == ~N[2022-11-20 20:48:00]
      assert movement_status.start_direction in InfleetMarsElixir.enum_keys(:direction)
      assert movement_status.start_position_x == 42
      assert movement_status.start_position_y == 42
      assert movement_status.status_code == 42
      assert movement_status.status_message == "some status_message"
      assert movement_status.terminal in InfleetMarsElixir.enum_keys(:movement)
    end

    test "create_movement_status/1 with invalid data returns error changeset" do
      assert {:error,
              %Ecto.Changeset{errors: [terminal: {"can't be blank", [validation: :required]}]}} =
               Movement.create_movement_status(@invalid_required_attrs)
    end

    test "create_movement_status/1 without required data returns error changeset" do
      assert {:error,
              %Ecto.Changeset{errors: [terminal: {"can't be blank", [validation: :required]}]}} =
               Movement.create_movement_status(@invalid_required_attrs)
    end

    test "update_movement_status/2 with valid data updates the movement_status" do
      movement_status = insert(:movement_status)

      update_attrs = %{
        completed: false,
        end_direction: :N,
        end_position_x: 43,
        end_position_y: 43,
        model_version: "some updated model_version",
        sent_at: ~N[2022-11-21 20:48:00],
        start_direction: :N,
        start_position_x: 43,
        start_position_y: 43,
        status_code: 43,
        status_message: "some updated status_message",
        terminal: :M
      }

      assert {:ok, %MovementStatus{} = movement_status} =
               Movement.update_movement_status(movement_status, update_attrs)

      assert movement_status.completed == false
      assert movement_status.end_direction == :N
      assert movement_status.end_position_x == 43
      assert movement_status.end_position_y == 43
      assert movement_status.model_version == "some updated model_version"
      assert movement_status.sent_at == ~N[2022-11-21 20:48:00]
      assert movement_status.start_direction == :N
      assert movement_status.start_position_x == 43
      assert movement_status.start_position_y == 43
      assert movement_status.status_code == 43
      assert movement_status.status_message == "some updated status_message"
      assert movement_status.terminal == :M
    end

    test "update_movement_status/2 with invalid data returns error changeset" do
      movement_status = insert(:movement_status)

      assert {:error,
              %Ecto.Changeset{errors: [terminal: {"can't be blank", [validation: :required]}]}} =
               Movement.update_movement_status(movement_status, @invalid_required_attrs)

      assert movement_status == Movement.get_movement_status!(movement_status.id)
    end

    test "delete_movement_status/1 deletes the movement_status" do
      movement_status = insert(:movement_status)
      assert {:ok, %MovementStatus{}} = Movement.delete_movement_status(movement_status)

      assert_raise Ecto.NoResultsError, fn ->
        Movement.get_movement_status!(movement_status.id)
      end
    end

    test "change_movement_status/1 returns a movement_status changeset" do
      movement_status = insert(:movement_status)
      assert %Ecto.Changeset{} = Movement.change_movement_status(movement_status)
    end
  end
end
