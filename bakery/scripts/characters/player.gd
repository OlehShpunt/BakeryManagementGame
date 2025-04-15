class_name Player 
extends CharacterBody2D

# Data for multiplayer
var player_info = {}

# Last movement direction is updated when awsd pressed
@export var speed : int
@export var money_balance = 50
@onready var animation_player = $PlayerAnimationPlayer
@onready var inventory = $Camera2D/Inventory
@onready var camera = $Camera2D
@onready var playerName = $Name
var last_direction = "s"
var test_github = false
var test_version_control = true

var inventory_resources : InventoryResource = preload("res://resources/gui/inventory_resource.tres")

var debug = 0

func _ready():
	#print("spawned in ", get_owner(), " at ", global_position)
	#print(self.position)
	if !is_multiplayer_authority():
		camera.enabled = false
	pass # Replace with function body.
	
	# Set up name
	if player_info:
		playerName.text = player_info.get("name", "no-name")
	
	#print("$$$$ player.name = ", name)
	#print("$$$$ player.get_multiplayer_authority() = ", get_multiplayer_authority())
	#print("$$$$ player.get_instance_id() = ", get_instance_id())

func _process(_delta: float) -> void:
	$CoordinateDisplay.text = str("%.2f" % global_position.x) + ", " + str("%.2f" % global_position.y)
	#debug = debug + 1
	#if debug == 400 && is_multiplayer_authority():
		#print("Item 1:", inventory_resources.get_item(0))
		#print("Item 2:", inventory_resources.get_item(1))
		#print("Item 3:", inventory_resources.get_item(2))
		#print("Item 4:", inventory_resources.get_item(3))
		#print()
		#debug = 0
	pass

func _physics_process(_delta):
	if is_multiplayer_authority():
		player_movement() # delta not needed since move_and_slide does the delta multiplication
		move_and_slide()
		
		# Sync position and animation state with other peers in the same scene
		for player_id in player_location_lists.get_player_ids_in_same_scene():
			rpc_id(player_id, "update_position", global_position)
			rpc_id(player_id, "update_animation", last_direction, velocity != Vector2.ZERO)

func _input(_event):
	pass
	#if event.is_action_pressed("spawn_fireball_c"):
		#$jutsu_spawner.spawn_fireball()

func player_movement():
	var direction = Input.get_vector("a", "d", "w", "s")
	velocity = direction * speed
	play_animation(direction)

func play_animation(direction):
	if direction != Vector2.ZERO:  # If awsd pressed, play walk
		if direction.y > 0: # s pressed
			animation_player.play("down_walk")
			last_direction = "s"
		elif direction.y < 0: # w pressed
			animation_player.play("up_walk")
			last_direction = "w"
		elif direction.x > 0: # d pressed
			animation_player.play("right_walk")
			last_direction = "d"
		elif direction.x < 0: # a pressed
			animation_player.play("left_walk")
			last_direction = "a"
	else:  # If no awsd pressed, play idle
		match last_direction:
			"a":
				animation_player.play("left_idle")
			"d":
				animation_player.play("right_idle")
			"w":
				animation_player.play("up_idle")
			"s":
				animation_player.play("down_idle")

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
	if not is_multiplayer_authority():  # Only non-authority peers update position
		global_position = new_position

@rpc("any_peer", "call_remote", "reliable")
func update_animation(direction: String, is_moving: bool):
	if not is_multiplayer_authority():  # Only non-authority peers update animation
		last_direction = direction
		if is_moving:
			match direction:
				"s": animation_player.play("down_walk")
				"w": animation_player.play("up_walk")
				"d": animation_player.play("right_walk")
				"a": animation_player.play("left_walk")
		else:
			match direction:
				"a": animation_player.play("left_idle")
				"d": animation_player.play("right_idle")
				"w": animation_player.play("up_idle")
				"s": animation_player.play("down_idle")


func player():
	pass
