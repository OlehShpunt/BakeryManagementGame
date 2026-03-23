class_name SpawnPlayerUseCase
extends RefCounted

func execute(location: EnumHolder.Location, coordinates: Vector2) -> void:
	print("[DEV][A] Spawning a player at %s ..." % [coordinates])

	EventBus.spawn_player.emit(location, coordinates)
