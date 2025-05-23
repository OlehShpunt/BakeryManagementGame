class_name npc_customer
extends CharacterBody2D

var ID : int = -1

# Path points are stored in reversed order,
#  i.g. first one is at index -1, second is at -2 etc.
# Actual first path point is at last index in array
var path = []
var next_coordinate : Vector2 = Vector2.ZERO
var speed : int = 40


func _ready() -> void:
	print("Customer with id ", ID, " initialized")


func _process(delta: float) -> void:
	if not path.is_empty():
		
		if next_coordinate == Vector2.ZERO:
			next_coordinate = path[-1].get_rand_coordinate()
		
		# If haven't reached the next coordinate yet, keep moving
		if next_coordinate != global_position:
			var velocity : Vector2 = (next_coordinate - global_position).normalized() * speed
			move_and_slide()
		# If reached, get new coordinate if any (at next frame)
		else:
			path.remove_at(-1)
			next_coordinate = Vector2.ZERO
