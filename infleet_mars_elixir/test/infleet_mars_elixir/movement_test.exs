defmodule InfleetMarsElixir.MovementTest do
  use InfleetMarsElixir.DataCase

  alias InfleetMarsElixir.Movement

  describe "context/methods" do
    alias InfleetMarsElixir.Movement.Movables

    test "move/2 case 1" do
      movable = insert(:movables, %{x: 1, y: 2, direction: :N})
      movement = insert(:movements, %{movables_id: movable.id, terminals: "EMEMEMEMM"})

      Movement.set_world(5, 5)

      %Movables{} = result = Movement.move(movable, movement)
      assert Movement.format(result) == "1 3 N"
    end

    test "move/2 case 2" do
      movable = insert(:movables, %{x: 3, y: 3, direction: :L})
      movement = insert(:movements, %{movables_id: movable.id, terminals: "MMDMMDMDDM"})

      Movement.set_world(5, 5)

      %Movables{} = result = Movement.move(movable, movement)
      assert Movement.format(result) == "5 1 L"
    end

    test "list_movables/0 returns all movables" do
      movables_list = insert_list(2, :movables)
      assert Movement.list_movables() == movables_list
    end
  end

  describe "context/schema movables" do
    alias InfleetMarsElixir.Movement.Movables

    test "list_movables/0 returns all movables" do
      movables_list = insert_list(2, :movables)
      assert Movement.list_movables() == movables_list
    end

    test "get_movables!/1 returns the movables with given id" do
      movables = insert(:movables)
      assert Movement.get_movables!(movables.id) == movables
    end

    test "create_movables/1 with valid data creates a movables" do
      valid_attrs = %{direction: :N, x: 42, y: 42}

      assert {:ok, %Movables{} = movables} = Movement.create_movables(valid_attrs)

      assert movables.direction == :N
      assert movables.x == 42
      assert movables.y == 42
    end

    test "create_movables/1 with invalid data returns error changeset" do
      invalid_attrs = %{direction: 42, x: 42, y: 42}
      assert {:error, %Ecto.Changeset{errors: errors}} = Movement.create_movables(invalid_attrs)

      assert errors == [
               direction:
                 {"is invalid",
                  [
                    type:
                      {:parameterized, Ecto.Enum,
                       %{
                         embed_as: :self,
                         mappings: [N: 0, L: 1, S: 2, O: 3],
                         on_cast: %{"L" => :L, "N" => :N, "O" => :O, "S" => :S},
                         on_dump: %{L: 1, N: 0, O: 3, S: 2},
                         on_load: %{0 => :N, 1 => :L, 2 => :S, 3 => :O},
                         type: :integer
                       }},
                    validation: :cast
                  ]}
             ]
    end

    test "update_movables/2 with valid data updates the movables" do
      movables = insert(:movables)
      update_attrs = %{direction: :S, x: 43, y: 43}

      assert {:ok, %Movables{} = movables} = Movement.update_movables(movables, update_attrs)
      assert movables.direction == :S
      assert movables.x == 43
      assert movables.y == 43
    end

    test "update_movables/2 with invalid data returns error changeset" do
      invalid_attrs = %{direction: 42, x: 42, y: 42}
      movables = insert(:movables)

      assert {:error, %Ecto.Changeset{errors: errors}} =
               Movement.update_movables(movables, invalid_attrs)

      assert movables == Movement.get_movables!(movables.id)

      assert errors == [
               direction:
                 {"is invalid",
                  [
                    type:
                      {:parameterized, Ecto.Enum,
                       %{
                         embed_as: :self,
                         mappings: [N: 0, L: 1, S: 2, O: 3],
                         on_cast: %{"L" => :L, "N" => :N, "O" => :O, "S" => :S},
                         on_dump: %{L: 1, N: 0, O: 3, S: 2},
                         on_load: %{0 => :N, 1 => :L, 2 => :S, 3 => :O},
                         type: :integer
                       }},
                    validation: :cast
                  ]}
             ]
    end

    test "delete_movables/1 deletes the movables" do
      movables = insert(:movables)
      assert {:ok, %Movables{}} = Movement.delete_movables(movables)
      assert_raise Ecto.NoResultsError, fn -> Movement.get_movables!(movables.id) end
    end

    test "change_movables/1 returns a movables changeset" do
      movables = insert(:movables)
      assert %Ecto.Changeset{} = Movement.change_movables(movables)
    end
  end

  describe "context/schema movements" do
    alias InfleetMarsElixir.Movement.Movements

    test "list_movements/0 returns all movements" do
      movements_list = insert_list(2, :movements)
      assert Movement.list_movements() == movements_list
    end

    test "get_movements!/1 returns the movements with given id" do
      movements = insert(:movements)
      assert Movement.get_movements!(movements.id) == movements
    end

    test "create_movements/1 with valid data creates a movements" do
      valid_attrs = %{terminals: "M", movables: Map.from_struct(insert(:movables))}

      assert {:ok, %Movements{} = movements} = Movement.create_movements(valid_attrs)

      assert movements.completed == false
      assert movements.errorIndexes == nil
      assert movements.lastIndex == nil
      assert movements.terminals == "M"
      assert %InfleetMarsElixir.Movement.Movables{} = movements.movables
    end

    test "create_movements/1 without required data returns error changeset" do
      required_attrs = %{terminals: nil}

      assert {
               :error,
               %Ecto.Changeset{
                 errors: [
                   terminals: {"can't be blank", [validation: :required]}
                 ]
               }
             } = Movement.create_movements(required_attrs)
    end

    test "create_movements/1 with invalid terminals returns error changeset" do
      invalid_terminals = %{
        terminals: "not a movement enum",
        movables: Map.from_struct(insert(:movables))
      }

      assert {
               :error,
               %Ecto.Changeset{
                 errors: [
                   terminals: {"must be valid movementEnum", [validation: :format]}
                 ]
               }
             } = Movement.create_movements(invalid_terminals)
    end

    test "update_movements/2 with valid data updates the movements" do
      movements = insert(:movements)

      update_attrs = %{
        completed: true,
        errorIndexes: [],
        lastIndex: 10,
        terminals: "MMM"
      }

      assert {:ok, %Movements{} = movements} = Movement.update_movements(movements, update_attrs)
      assert movements.completed == true
      assert movements.errorIndexes == []
      assert movements.lastIndex == 10
      assert movements.terminals == "MMM"
    end

    test "update_movements/2 without required data returns error changeset" do
      required_attrs = %{terminals: nil}

      movements = insert(:movements)
      assert {:error, %Ecto.Changeset{}} = Movement.update_movements(movements, required_attrs)
      assert movements == Movement.get_movements!(movements.id)
    end

    test "delete_movements/1 deletes the movements" do
      movements = insert(:movements)
      assert {:ok, %Movements{}} = Movement.delete_movements(movements)
      assert_raise Ecto.NoResultsError, fn -> Movement.get_movements!(movements.id) end
    end

    test "change_movements/1 returns a movements changeset" do
      movements = insert(:movements)
      assert %Ecto.Changeset{} = Movement.change_movements(movements)
    end
  end

  describe "context/schema movements_statuses" do
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
        index: 0,
        end_direction:
          InfleetMarsElixir.enum_values(:direction) |> InfleetMarsElixir.Random.pick(),
        end_position_x: 42,
        end_position_y: 42,
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
              %Ecto.Changeset{
                errors: [
                  terminal: {"can't be blank", [validation: :required]},
                  index: {"can't be blank", [validation: :required]}
                ]
              }} = Movement.create_movement_status(@invalid_required_attrs)
    end

    test "create_movement_status/1 without required data returns error changeset" do
      assert {:error,
              %Ecto.Changeset{
                errors: [
                  terminal: {"can't be blank", [validation: :required]},
                  index: {"can't be blank", [validation: :required]}
                ]
              }} = Movement.create_movement_status(@invalid_required_attrs)
    end

    test "update_movement_status/2 with valid data updates the movement_status" do
      movement_status = insert(:movement_status)

      update_attrs = %{
        completed: false,
        end_direction: :N,
        end_position_x: 43,
        end_position_y: 43,
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
