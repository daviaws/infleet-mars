# this scripts contains the history from project scafolding from 0

# https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Context.html#content

# https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

# setup enums (Ecto.Enum)

# movementStatus (1.0)
# terminal: movementEnum
# completed: bool
# statusCode: integer default 1 (unclassified) (for further classification)
# statusMessage: string default 1 (unclassified) (for further classification)
# startPositionX: integer
# startPositionY: integer
# startDirection: directionEnum
# endPositionX: integer
# endPositionY: integer
# endDirection: directionEnum
# modelVersion: string
mix phx.gen.context Movement MovementStatus movements_statuses \
    terminal:integer \
    completed:boolean \
    status_code:integer \
    status_message:string \
    sent_at:naive_datetime \
    start_position_x:integer \
    start_position_y:integer \
    start_direction:integer \
    end_position_x:integer \
    end_position_y:integer \
    end_direction:integer \
    model_version:string

# movements (1.0)
mix phx.gen.context Movement Movements movements \
    terminals:string \
    completed:boolean \
    lastIndex:integer \
    errorIndexes:array:integer

# add movementStatus (1.0) index and movements fk
mix ecto.gen.migration add_movements_status_movements_fk

# movables (1.0) (e.g. car)
mix phx.gen.context Movement Movables movables \
    x:integer \
    y:integer \
    direction:integer \
    model_version:string

# add movements (1.0) movable fk
mix ecto.gen.migration add_movements_movable_fk

# movables api (1.0)
mix phx.gen.json Movement Movables movables \
    x:integer \
    y:integer \
    direction:string \
    --no-context --no-schema

# movements api (1.0)
mix phx.gen.json Movement Movements movements \
    terminals:string \
    movables_id:integer \
    --no-context --no-schema

# add new endpoint to set world limit
mix phx.gen.json Movement World worlds \
    x:integer \
    y:integer \
    --no-context --no-schema