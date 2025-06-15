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

var registered_path_points : Array = []


func _ready() -> void:
	registered_path_points.resize(50)


func register_path_point(id : int, path_point_ref):
	
	var err
	
	if registered_path_points[id] != null:
		err = ERR_DUPLICATE_SYMBOL
	else:
		err = OK
	
	registered_path_points[id] = path_point_ref
	
	return err


func get_path_point_ref(id : int):
	return registered_path_points[id]


func get_path_point_ref__param_Vector2(coord : Vector2):
	for path_point_ref in registered_path_points:
			if path_point_ref:
				if path_point_ref.get_global_coordinate() == coord:
					return path_point_ref
	
	push_warning("Given coordinate does not match any registered path point coordinate")
	return ERR_DOES_NOT_EXIST


# TELEPORTS

# id as String
# |
# -- "ref" : as Teleport
# |
# -- "g_pos" : as Vector2
# |
# -- "teleport_to" : as String
var registered_teleports : Dictionary = {}


func register_teleport(teleport : Teleport):
	registered_teleports[str(teleport.get_id())] = {"ref" : null, "g_pos" : null, "teleport_to" : null}
	registered_teleports[str(teleport.get_id())]["ref"] = teleport
	registered_teleports[str(teleport.get_id())]["g_pos"] = teleport.global_position
	registered_teleports[str(teleport.get_id())]["teleport_to"] = teleport.get_teleport_to_path()


func teleport_vector2_to_location_path(given_position : Vector2) -> String:
	# Each key is a string with teleport id
	for key in registered_teleports:
		if registered_teleports[key]["g_pos"] == given_position:
			return registered_teleports[key]["teleport_to"]
	
	push_warning("Given position does not match any registered Teleport")
	return path_holder.EMPTY

func get_teleport_dict(id: String) -> Dictionary:
	if registered_teleports.has(id):
		return registered_teleports[id]
	else:
		return {}

func get_teleport_global_pos(id: String) -> Vector2:
	if get_teleport_dict(id).has("g_pos"):
		return get_teleport_dict(id)["g_pos"]
	else:
		print("*** returned dict is empty")
		return Vector2.ZERO


## NAVIGATION REGION 2D

var registered_nav_regions = {}


func register_nav_region(id : String, nav_reg_ref):
	
	var err
	
	if registered_nav_regions.has(id):
		err = ERR_DUPLICATE_SYMBOL
	else:
		err = OK
	
	registered_nav_regions[id] = nav_reg_ref

	return err
