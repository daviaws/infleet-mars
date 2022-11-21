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
