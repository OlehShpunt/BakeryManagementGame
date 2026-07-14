class_name MultiplayerPlayer
extends CharacterBody2D

var state: MultiplayerPlayerState


func _ready() -> void:
	$Name.text = state.name


func _process(delta: float) -> void:
	if (StateManager.get_player_state().get_player_location() == state.location):
		show()
	else:
		hide()
		pass

	position = state.position
