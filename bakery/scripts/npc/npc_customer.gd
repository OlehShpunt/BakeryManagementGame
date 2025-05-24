class_name npc_customer
extends CharacterBody2D

var ID : int = -1

# Path points are stored in reversed order,
#  i.g. first one is at index -1, second is at -2 etc.
# Actual first path point is at last index in array
var path = []
var next_coordinate : Vector2 = Vector2.ZERO
var speed : int = 100


func _ready() -> void:
	
	global_position = Vector2(50, 50)
	
	$ID.text = str(ID)
	
	print("Customer with id ", ID, " initialized")


func _process(delta: float) -> void:
	if not path.is_empty():
		
		# If we don't have a target yet, get the next point
		if next_coordinate == Vector2.ZERO:
			next_coordinate = path[-1]
			print("New target coordinate assigned: ", next_coordinate)

		# Calculate direction and set velocity
		velocity = (next_coordinate - global_position).normalized() * speed

		# Move the character first
		move_and_slide()

		# After movement, check if reached the coordinate
		if next_coordinate.distance_to(global_position) < 2:
			path.resize(path.size() - 1)
			next_coordinate = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		move_and_slide()



func are_close(v1 : Vector2, v2 : Vector2, acceptable_difference_value : int = 10) -> bool:
	var v1_f = Vector2(floor(v1.x), floor(v1.y))
	var v2_f = Vector2(floor(v2.x), floor(v2.y))
	
	if abs(v1_f.x - v2_f.x) > acceptable_difference_value:
		return false
	
	if abs(v1_f.y - v2_f.y) > acceptable_difference_value:
		return false
	
	return true
