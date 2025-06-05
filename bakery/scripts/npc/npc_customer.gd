class_name npc_customer
extends CharacterBody2D

var ID : int = -1
@onready var npc_current_location_path = path_holder.STREET_PATH  # Default val, changed when npc reaches end point and changes its current location


signal npc_current_location_path_changed(new_npc_current_location_path)


## Emitted when npc reaches an end point and is ready to change own current location and get new path
signal change_own_location()


# Path points are stored in reversed order,
#  i.g. first one is at index -1, second is at -2 etc.
# Actual first path point is at last index in array
var path = []

var next_coordinate : Vector2 = Vector2.ZERO
@export var speed : int = 20


func _ready() -> void:
	
	global_position = Vector2(50, 50)
	
	$ID.text = str(ID)
	
	print("Customer with id ", ID, " initialized")
	
	player_location_lists.locations_changes.connect(on_location_changed)
	npc_current_location_path_changed.connect(on_npc_current_location_path_changed)


var last_path_point_vector2 : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	
	if not path.is_empty():
		
		# If we don't have a target path point yet, get the next point
		if next_coordinate == Vector2.ZERO:
			next_coordinate = path[-1]
			print("New target coordinate assigned: ", next_coordinate)
		
		last_path_point_vector2 = next_coordinate
		
		# Calculate direction and set velocity
		velocity = (next_coordinate - global_position).normalized() * speed

		# Move the character first
		move_and_slide()

		# After movement, check if reached the coordinate
		# If reached, remove the last coordinate from path array, and save last coordinate in last_path_point_vector2
		if next_coordinate.distance_to(global_position) < 2:
			
			# If reached last path point
			if path.size() == 1:
				var path_point_ref = global_ref_register.get_path_point_ref__param_Vector2(last_path_point_vector2)
				# If not ERR_DOES_NOT_EXIST
				if path_point_ref is not int:
					# Casting to type npc_path_point for convenience
					path_point_ref = path_point_ref as npc_path_point
					
					var target_scene : String = path_point_ref.get_target_scene()
					
					if target_scene != "":
						change_npc_location_path(target_scene)
						# Hide or show self
						on_location_changed(player_location_lists.get_locations())
					else:
						push_warning("Target scene not specified at end path point")
				
				else:
					push_warning("get_path_point_ref__param_Vector2() returned ERR_DOES_NOT_EXIST")
					
			
			path.resize(path.size() - 1)
			
			# Tracking last path point coordinate
			last_path_point_vector2 = next_coordinate
			
			next_coordinate = Vector2.ZERO
	
	# If path is empty
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


func change_npc_location_path(new_location_path : String):
	npc_current_location_path = new_location_path
	emit_signal("npc_current_location_path_changed", new_location_path)


## Called when the playern or self changes location
## Hide or show self if in same location as player
func on_location_changed(location_list):
	print("*** called on loc changed")
	
	# TODO lambda for deferred_call()
	
	call_deferred("deferred_call", location_list)
# TODO lambda
func deferred_call(location_list):
	var current_location_path : String = get_tree().current_scene.get_location_path()
	
	print("*** current_location_path = ", current_location_path)
	
	if location_list[npc_current_location_path].has(get_multiplayer_authority()):
		self.show()
		print("*** showing npc")
	else:
		self.hide()
		print("*** hiding npc")


func on_npc_current_location_path_changed(new_location_path : String):
	print("**** new location ", new_location_path)
