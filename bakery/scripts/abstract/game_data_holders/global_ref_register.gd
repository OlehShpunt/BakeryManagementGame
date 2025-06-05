extends Node


# "ID : String" - "seller node reference : Object" pair
var registered_sellers : Dictionary = {}


func register_seller(seller_id, seller_node_ref):
	registered_sellers[str(seller_id)] = seller_node_ref


func is_seller_registered(seller_id) -> bool:
	if registered_sellers.has(str(seller_id)):
		return true
	else:
		return false


func get_seller_ref(seller_id : String):
	if seller_id != "-1":
		if registered_sellers.has(str(seller_id)):
			return registered_sellers[str(seller_id)]
		else:
			push_warning("The specified seller id is not registered, so null is returned")
			return null
	else:
		push_warning("The specified seller id is invalid (", seller_id, "), so null is returned")
		return null


## PATH POINTS

var registered_path_points : Dictionary = {}


func register_path_point(id, path_point_ref):
	registered_path_points[str(id)] = path_point_ref


func get_path_point_ref(id):
	if registered_path_points.has(str(id)):
		return registered_path_points[str(id)]
	else:
		push_warning("The specified seller id is not registered, so null is returned")
		return null


func get_path_point_ref__param_Vector2(coord : Vector2):
	for key in registered_path_points:
		if registered_path_points[key].get_global_coordinate() == coord:
			return registered_path_points[key]
	
	push_warning("Given coordinate does not match any registered path point coordinate")
	return ERR_DOES_NOT_EXIST
