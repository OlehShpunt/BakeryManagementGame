class_name npc_customer
extends CharacterBody2D

var ID : int = -1
@onready var npc_current_location_path = path_holder.STREET_PATH  # Default val, changed when npc reaches end point and changes its current location


# Path points are stored in reversed order,
#  i.g. first one is at index -1, second is at -2 etc.
# Actual first path point is at last index in array
var path = []
var next_coordinate : Vector2 = Vector2.ZERO
var speed : int = 20


func _ready() -> void:
	
	global_position = Vector2(50, 50)
	
	$ID.text = str(ID)
	
	print("Customer with id ", ID, " initialized")
	
	player_location_lists.locations_changes.connect(on_location_changed)


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


func teleport_npc_to(new_location_path : String):
	npc_current_location_path = new_location_path


func on_location_changed(location_list):
	print("*** called on loc changed")
	call_deferred("deferred_call", location_list)

func deferred_call(location_list):
	var current_location_path : String = get_tree().current_scene.get_location_path()
	
	print("*** current_location_path = ", current_location_path)
	
	if location_list[npc_current_location_path].has(get_multiplayer_authority()):
		self.show()
		print("*** showing npc")
	else:
		self.hide()
		print("*** hiding npc")
