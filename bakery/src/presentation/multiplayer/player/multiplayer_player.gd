class_name MultiplayerPlayer
extends CharacterBody2D

var state: MultiplayerPlayerState

var last_direction: String = "s"
@onready var animation_player: AnimationPlayer = $PlayerAnimationPlayer


func _ready() -> void:
	$Name.text = state.name


func _process(delta: float) -> void:
	if (StateManager.get_player_state().get_player_location() == state.location):
		show()
	else:
		hide()
		pass

	var prev_pos := position
	var new_pos := state.position
	var direction := new_pos - prev_pos

	position = state.position

	play_animation(direction)


func play_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO: # If awsd pressed, play walk
		if direction.y > 0: # s pressed
			if direction.x > 0.85:
				animation_player.play("right_walk")
				last_direction = "d"
			elif direction.x < -0.85:
				animation_player.play("left_walk")
				last_direction = "a"
			else:
				animation_player.play("down_walk")
				last_direction = "s"
		elif direction.y < 0: # w pressed
			if direction.x > 0.85:
				animation_player.play("right_walk")
				last_direction = "d"
			elif direction.x < -0.85:
				animation_player.play("left_walk")
				last_direction = "a"
			else:
				animation_player.play("up_walk")
				last_direction = "w"
		elif direction.x > 0: # d pressed
			animation_player.play("right_walk")
			last_direction = "d"
		elif direction.x < 0: # a pressed
			animation_player.play("left_walk")
			last_direction = "a"
	else: # If no awsd pressed, play idle
		match last_direction:
			"a":
				animation_player.play("left_idle")
			"d":
				animation_player.play("right_idle")
			"w":
				animation_player.play("up_idle")
			"s":
				animation_player.play("down_idle")
