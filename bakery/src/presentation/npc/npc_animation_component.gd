extends Node2D

@onready var animation_player = $AnimationPlayer

var direction: Vector2 = Vector2.ZERO
var last_direction: String = "down"

var previous_position: Vector2
var position_timer := 0.0
const POSITION_UPDATE_INTERVAL := 0.2

func _ready():
	previous_position = global_position

func _physics_process(delta):
	# Update timer and check if 0.2s has passed
	position_timer += delta
	if position_timer >= POSITION_UPDATE_INTERVAL:
		# Calculate direction from position change
		direction = (global_position - previous_position)
		previous_position = global_position
		position_timer = 0.0

	# Determine animation
	if direction.length() > 1.0:  # Adjust threshold to prevent jitter
		play_move_animation(direction)
	else:
		play_idle_animation()

func play_move_animation(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			animation_player.play("right_walk")
			last_direction = "right"
		else:
			animation_player.play("left_walk")
			last_direction = "left"
	else:
		if dir.y > 0:
			animation_player.play("down_walk")
			last_direction = "down"
		else:
			animation_player.play("up_walk")
			last_direction = "up"

func play_idle_animation():
	animation_player.play(last_direction + "_idle")
