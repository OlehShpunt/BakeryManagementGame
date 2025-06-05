class_name path_point_resolver 
extends Node


func resolve_next_scene(coord : Vector2):
	var path_point = global_ref_register.get_path_point_ref__param_Vector2(coord)
	
	# If error code returned
	if path_point is int:
		return path_holder.EMPTY
	
	path_point.
