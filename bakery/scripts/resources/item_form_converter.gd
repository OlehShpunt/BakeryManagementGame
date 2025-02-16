class_name ItemFormConverter extends Resource

var flour_scene : PackedScene = preload("res://scenes/food/ingredients/flour.tscn")

func string_to_texture(string : String) -> Texture2D:
	#print(string)
	string = string.to_lower()
	return scene_manager.get_packed_scene(string, "ingredient").instantiate().get_texture()

# !!! will be probably removed and all occurrances replaced with scene_manager's get_packed_scene method
func string_to_scene(string : String) -> PackedScene:
	push_error("This method is deprecated")
	string = string.to_lower()
	if string == "flour":
		return flour_scene
	else:
		return null

func texture_to_scene(texture : Texture2D) -> PackedScene:
	print("to be implemented")
	return null

func scene_to_node(scene : PackedScene) -> Sprite2D:
	print("to be implemented")
	return null
