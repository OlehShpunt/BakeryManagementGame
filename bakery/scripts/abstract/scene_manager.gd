class_name SceneManager
extends Node


# The variable works like a state
var current_scene_path = path_holder.STREET_PATH


## manages game scene transitions
## holds all item packed scenes (they then can be retrieved by any script)
## sets a name to every packed scene (using resource_name's set_name(value))

## ITEM PACKED SCENE MANAGEMENT
# TODO: move to a separate global converter class
# Returns a packed scene of the specified item.
# @param1 name of the object
# @param2 type of the object (food/character/furniture/appliance etc.)
func get_packed_scene(item_name : String, object_type : String = "ingredient") -> PackedScene:
	# Returns respective to object_type folder (changed string in load())
	if (item_name != ""):
		if (object_type == "ingredient"):
			var to_return = load("res://scenes/food/ingredients/" + item_name + ".tscn")
			to_return.set_name(item_name)
			return to_return
		elif (object_type == "bakery"):
			var to_return = load("res://scenes/food/bakery/" + item_name + ".tscn")
			to_return.set_name(item_name)
			return to_return
		else:
			push_error("\"" + object_type + "\" is an invalid value for object_type. ")
			return null
	else:
		push_error("item_name has a value of \"\"")
	
	return null

## SCENE TRANSITION MANAGEMENT
var first_load = true
var player : Player = preload("res://scenes/characters/player.tscn").instantiate()
var previous_scene : PackedScene
var current_scene : PackedScene

##leaving some comments
func transition_scene(_from, teleport_used : Teleport, body : Player) -> void:
	# Get the reference of the player to be teleported from 
	# the scene where teleport_used is located
	self.player = body # from
	# Removing the player from the scene it is in before teleportation
	self.player.get_parent().remove_child(player)
	
	# Each Teleport has its own teleport_to var, which
	# specifies the destination scene. Its value is explicitly 
	# specified using @export_enum in each teleport.
	previous_scene = current_scene
	current_scene = load("res://scenes/locations/" +  teleport_used.teleport_to + ".tscn")
	call_deferred("actual_transition") # I was getting an error, sooo this was used

# Needed to debug this error: Removing a CollisionObject node during a physics callback is not allowed and will cause undesired behavior. Remove with call_deferred() instead.
func actual_transition():
	get_tree().change_scene_to_packed(current_scene)
	

## NEW SCENE TRANSITION MANAGEMENT OVER NETWORK
@rpc("any_peer", "call_local", "reliable")
func load_scene(scene_path: String, _spawn_position: Vector2):
	var new_scene = load(scene_path).instantiate()
	
	# Replace current scene
	var tree = get_tree()

	if tree.current_scene:
		tree.current_scene.queue_free()
	tree.root.add_child(new_scene)
	tree.current_scene = new_scene

	multiplayer_manager.spawn_all_players(player_location_lists.get_list_of_players(scene_path), scene_path)

## ON SERVER ONLY
## Teleport a specific peer to the specified scene
func teleport_player(peer_id: int, location_path: String, _spawn_position: Vector2):
	print("in teleport_player right now (teleport)")
	if not multiplayer.is_server():
		print("true: not multiplayer.is_server(), so returning the process")
		return
	
	# Move player from one location to another (TODO: creatae move_player(player_id, from_location, to_location) function in player_location_lists singleton)
	var player_info = player_location_lists.remove_player(current_scene_path, peer_id)
	player_location_lists.add_player(location_path, peer_id, player_info)
	
	# Reset to new scene path (the current_scene_path variable works like state)
	current_scene_path = location_path
	
	rpc_id(peer_id, "load_scene", location_path, _spawn_position)
