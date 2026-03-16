class_name SpawnPlayerUseCase
extends RefCounted

func execute(coordinates: Vector2) -> void:
	print("[DEV][A] Spawning a player at %s ..." % [coordinates])

	EventBus.spawn_player.emit(coordinates)
