class_name SceneManager
extends Node

## - manages game scene transitions
## - holds all item packed scenes (they then can be retrieved by any script)
## - sets a name to every packed scene (using resource_name's set_name(value))

## ITEM PACKED SCENE MANAGEMENT
# Returns a packed scene of the specified item.
# @param1 name of the object
# @param2 type of the object (food/character/furniture/appliance etc.)
func get_packed_scene(item_name : String, object_type : String = "ingredient") -> PackedScene:
	print("get_packed_scene called, arguments passed: ", item_name, " --- ", object_type)
	# Returns respective to object_type folder (changed string in load())
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

## SCENE TRANSITION MANAGEMENT
var first_load = true
var player : Player = preload("res://scenes/characters/player.tscn").instantiate()
var previous_scene : PackedScene
var current_scene : PackedScene

func transition_scene(from, teleport_used : Teleport, body : Player) -> void:
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
