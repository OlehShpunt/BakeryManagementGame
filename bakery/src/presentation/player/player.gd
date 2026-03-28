class_name Player
extends CharacterBody2D

# Last movement direction is updated when awsd pressed
@export var speed: int
@onready var animation_player: AnimationPlayer = $PlayerAnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var player_name: Label = $Name
@onready var coordinate_display: Label = $CoordinateDisplay
var last_direction: String = "s"
var _player_movement_disabled = false

## Turn on to see player coordinates
@export var show_coordinates: bool = false


func _ready() -> void:
	StateManager.get_player_state().player_ref = self

	if show_coordinates:
		coordinate_display.show()
	else:
		coordinate_display.hide()

	player_name.text = StateManager.get_player_state().get_player_name()

	PresentationEventBus.disable_player_movement.connect(_on_disable_player_movement)
	PresentationEventBus.enable_player_movement.connect(_on_enable_player_movement)


func _process(_delta: float) -> void:
	if show_coordinates:
		coordinate_display.text = str("%.2f" % global_position.x) + ", " + str("%.2f" % global_position.y)


func _physics_process(_delta: float) -> void:
	player_movement() # delta not needed since move_and_slide does the delta multiplication
	var _body_collided: bool = move_and_slide()


func player_movement() -> void:
	if (_player_movement_disabled):
		return

	var direction: Vector2 = Input.get_vector("a", "d", "w", "s")
	velocity = direction * speed
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


func _on_disable_player_movement():
	_player_movement_disabled = true


func _on_enable_player_movement():
	_player_movement_disabled = false
