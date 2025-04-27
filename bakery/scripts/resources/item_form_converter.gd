class_name ItemFormConverter extends Node


var flour_scene : PackedScene = preload("res://scenes/food/ingredients/flour.tscn")


# Function to get image path based on scene path
func get_image_path_from_scene(scene_path: String) -> String:
	if scene_path == path_holder.EMPTY:
		return path_holder.EMPTY
	
	if path_holder.scene_to_image_map.has(scene_path):
		return path_holder.scene_to_image_map[scene_path]
	
	# Default
	push_warning("Could not find the mapping to scene path ", scene_path)
	return path_holder.EMPTY

# Function to get scene path based on image path
func get_scene_path_from_image(image_path: String) -> String:
	if image_path == path_holder.EMPTY:
		return path_holder.EMPTY
	
	for scene_path in path_holder.scene_to_image_map.keys():
		if path_holder.scene_to_image_map[scene_path] == image_path:
			return scene_path
	
	# Default
	push_warning("Could not find the mapping to image path ", image_path)
	return path_holder.EMPTY


# Function to load an image and create a texture
func get_texture_from_image_path(image_path: String) -> Texture:
	if image_path == path_holder.EMPTY:
		return null
	
	var texture = load(image_path)  # Load the image as a texture resource
	
	if texture:
		return texture
	else:
		push_warning("Failed to load texture at path (conversion path -> texture failed): ", image_path)
		return null


func get_texture_from_scene_path(scene_path):
	var image_path = get_image_path_from_scene(scene_path)
	return get_texture_from_image_path(image_path)

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
