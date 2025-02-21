class_name ItemFormConverter extends Node

var flour_scene : PackedScene = preload("res://scenes/food/ingredients/flour.tscn")

func string_to_texture(string : String) -> Texture2D:
	if (string == "" or string == null):
		push_error("string has a value of \"\"")
		return null
	else:
		string = string.to_lower()
		return scene_manager.get_packed_scene(string, "ingredient").instantiate().get_texture()

## TODO move get_packed_scene() form scene_manager to this script AND rename the method
# !!! will be probably removed and all occurrances replaced with scene_manager's get_packed_scene method
func string_to_scene(string : String) -> PackedScene:
	push_error("This method is deprecated")
	string = string.to_lower()
	if string == "flour":
		return flour_scene
	else:
		return null

## TODO
#func texture_to_scene(texture : Texture2D) -> PackedScene:
	#print("to be implemented")
	#return null

## TODO
#func scene_to_node(_scene : PackedScene) -> Sprite2D:
	#print("to be implemented")
	#return null
