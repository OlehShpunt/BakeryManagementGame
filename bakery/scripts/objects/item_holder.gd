class_name ItemHolder extends StaticBody2D

#var item_texture : Texture2D
@onready var texture = $TextureRect
var current_item_string : String = ""

var mouse_is_hovering = false

func _ready() -> void:
	pass
	#set_texture(item_texture)

func set_item(item_to_add : String):
	if (texture.texture == null):
		texture.set_texture(item_form_converter.string_to_texture(item_to_add))
		set_current_item_string(item_to_add)
	else:
		push_error("The texture already holds an item")

func _input(event: InputEvent) -> void:
	# When hover over cell and left click, you pick the item and move it.
	if event.is_action_pressed("left_click") and mouse_is_hovering and current_item_string != "":
		print(">>>>> Picking the ", current_item_string)
		var item_scene = scene_manager.get_packed_scene(current_item_string)
		add_child(item_scene.instantiate())
		empty_cell() # remove the texture from this cell
		# Access the last child - the floating item. 
		# When is_being_moved_by_mouse true, the global pos is same as mouse's gl pos
		get_child(-1).is_being_moved_by_mouse = true
		get_child(-1).z_index = 15

func empty_cell():
	texture.set_texture(null)

func _on_cell_mouse_entered() -> void:
	print(">>>>mouse entered")
	mouse_is_hovering = true

func _on_cell_mouse_exited() -> void:
	print(">>>>mouse exited")
	mouse_is_hovering = false

func item_holder():
	pass

func set_current_item_string(value):
	current_item_string = value
