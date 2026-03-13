class_name npc_path_point 
extends Node2D


@export var ID : int
@export var default_radius : int = 0
## Scene the path holder teleports npc to, if it is an end point
@export var target_scene : String = path_holder.EMPTY

@onready var self_position = global_position


func _ready() -> void:
	pass
	# DEPRECATED
	#if ID:
		#var err = global_ref_register.register_path_point(ID, self)
		#
		## If OK
		#if err != ERR_DUPLICATE_SYMBOL:
			#call_deferred("reparent", path_point_parent)
		#
		### If already registered
		##if err == ERR_DUPLICATE_SYMBOL:
			##get_tree().current_scene.remove_child(self)
		### If not registered yet
		##else:
			##get_tree().current_scene.remove_child(self)
			##path_point_parent.add_child(self)
		#
	#else:
		#push_error("ID not set")


## Returns random distance away from global_position with max radius being a constraint
func get_rand_coordinate(radius : int = default_radius) -> Vector2:
	# Distance from the global pos
	var distance = randf_range(0.0, radius)
	# Angle from the global pos
	# Random value 0 - 360 (TAU is 2*PI)
	var angle = randf_range(0.0, TAU)
	# Vector from global pos
	var offset = Vector2(cos(angle), sin(angle)) * distance
	# Finalized random value
	return self_position + offset


func get_global_coordinate():
	return self_position


func get_target_scene():
	return target_scene
