extends Node2D

var _multiplayer_player_packed_scene: PackedScene = preload("res://src/presentation/multiplayer/player/multiplayer_player.tscn")
var _registry: Dictionary[String, MultiplayerPlayer]


func _ready() -> void:
	z_index = 1


## Display an existing registered player
func display_player(id: String) -> void:
	pass


## Register a new player who joined the game and add the node to root
func register_player(state: MultiplayerPlayerState) -> void:
	Console.print_info("registering player with id " + state.id)
	var instance: MultiplayerPlayer = _multiplayer_player_packed_scene.instantiate()
	instance.state = state
	add_child(instance)
	_registry.set(state.id, instance)
