extends Node

### Session Events
@warning_ignore("unused_signal")
signal start_game()

### Location Signals
@warning_ignore("unused_signal")
signal load_location(location: EnumHolder.Location)

### Player Signals
@warning_ignore("unused_signal")
signal spawn_player(location: EnumHolder.Location, coordinates: Vector2)
@warning_ignore("unused_signal")
signal despawn_player(id: String)
