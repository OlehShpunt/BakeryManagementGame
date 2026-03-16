class_name PlayerEventListener
extends Node

var player_packed_scene: PackedScene = load(PathHolder.PLAYER_SCENE_PATH)


func _init() -> void:
	EventBus.spawn_player.connect(_on_spawn_player)

	print("[DEV][P] PlayerEventListener initialized")


func _on_spawn_player(coordinates: Vector2) -> void:
	var player_instance: Player = player_packed_scene.instantiate()
	player_instance.position = coordinates
	await get_tree().process_frame
	get_tree().current_scene.add_child(player_instance)

	print("[DEV][P] Spawned a player at %s" % [coordinates])
