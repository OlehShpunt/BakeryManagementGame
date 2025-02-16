class_name Player 
extends CharacterBody2D

# Last movement direction is updated when awsd pressed
@export var speed = 150
@export var money_balance = 50
@onready var animation_player = $PlayerAnimationPlayer
@onready var inventory = $Camera2D/Inventory
var last_direction = "s";

var inventory_resources : InventoryResource = preload("res://resources/gui/inventory_resource.tres")

var debug = 0

func _ready():
	#print("spawned in ", get_owner(), " at ", global_position)
	#print(self.position)
	pass # Replace with function body.

func _process(delta: float) -> void:
	debug = debug + 1
	if (debug == 100):
		print("Item 1:", inventory_resources.get_item(0))
		print("Item 2:", inventory_resources.get_item(1))
		print("Item 3:", inventory_resources.get_item(2))
		print("Item 4:", inventory_resources.get_item(3))
		print()
		debug = 0
	pass

func _physics_process(_delta):
	player_movement() # delta not needed since move_and_slide does the delta multiplication
	move_and_slide()
	#print(global_position)

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

func player():
	pass
