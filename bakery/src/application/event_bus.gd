extends Node

### Session Events
signal start_game()

### Location Signals
signal load_location(location: EnumHolder.Location)

### Player Signals
signal spawn_player(location: EnumHolder.Location, coordinates: Vector2)
signal despawn_player(id: String)
