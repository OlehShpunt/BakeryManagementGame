class_name Player
extends CharacterBody2D

# Last movement direction is updated when awsd pressed
@export var speed: int
@export var money_balance = 50
@onready var animation_player = $PlayerAnimationPlayer
@onready var inventory = $Camera2D/Inventory
@onready var camera = $Camera2D
@onready var player_name: Label = $Name
@onready var coordinate_display = $CoordinateDisplay
var last_direction = "s"
var test_github = false
var test_version_control = true

## Turn on to see player coordinates
@export var show_coordinates: bool = false


func _ready():
	if show_coordinates:
		coordinate_display.show()
	else:
		coordinate_display.hide()

	player_name.text = StateManager.get_player_state().get_player_name()


func _process(_delta: float) -> void:
	if show_coordinates:
		coordinate_display.text = str("%.2f" % global_position.x) + ", " + str("%.2f" % global_position.y)


func _physics_process(_delta):
	player_movement() # delta not needed since move_and_slide does the delta multiplication
	move_and_slide()


func player_movement():
	var direction = Input.get_vector("a", "d", "w", "s")
	velocity = direction * speed
	play_animation(direction)


func play_animation(direction):
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

'''
# Inventory blocked when:
# 1) Player enters the InteractableZone of a Seller
func block_inventory():
	inventory.inventory_blocked = true


# Inventory unblocked when:
# 1) Player exits the InteractableZone of a Seller
func unblock_inventory():
	inventory.inventory_blocked = false


@rpc("any_peer", "call_remote", "reliable")
func update_position(new_position: Vector2):
	if not is_multiplayer_authority(): # Only non-authority peers update position
		global_position = new_position


@rpc("any_peer", "call_remote", "reliable")
func update_animation(direction: String, is_moving: bool):
	if not is_multiplayer_authority(): # Only non-authority peers update animation
		last_direction = direction
		if is_moving:
			match direction:
				"s":
					animation_player.play("down_walk")
				"w":
					animation_player.play("up_walk")
				"d":
					animation_player.play("right_walk")
				"a":
					animation_player.play("left_walk")
		else:
			match direction:
				"a":
					animation_player.play("left_idle")
				"d":
					animation_player.play("right_idle")
				"w":
					animation_player.play("up_idle")
				"s":
					animation_player.play("down_idle")
'''

func player():
	pass
