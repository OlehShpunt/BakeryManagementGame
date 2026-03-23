extends Node

var _player_state: PlayerState


func _init() -> void:
	_player_state = PlayerState.new()

	print("[DEV][A] State manager initialized")


func get_player_state() -> PlayerState:
	return _player_state
