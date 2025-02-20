class_name Ingredient extends Item

# The one currently hovering over with the item at mouse position
var recent_cell_area = null
var is_being_moved_by_mouse = false
var inventory_resource = preload("res://resources/gui/inventory_resource.tres")
var storage1_resource = preload("res://resources/objects/storage1_resource.tres")
var cooking_gui_resource = preload("res://resources/gui/cooking_gui_resource.tres")

func _ready() -> void:
	# Z-index is overriden by subclass (value 0) at runtime, so no matter what z-index I statically set in this class in attributes, it is later overriden, unless I override it again down here.
	z_index = 30 # Needed to make floating items not be below other game elements, like furniture or walls.
	# Required when I instantiate and add the area at runtime, but I decided to put it in the Ingredient scene manually
	var interactive_area = preload("res://scenes/food/ingredients/ingredient_interactive_area.tscn")
	var interactive_area_instance = interactive_area.instantiate()
	add_child(interactive_area_instance)
	#interactive_area_instance.connect("body_entered", _on_interactive_area_entered)
	#interactive_area_instance.connect("body_exited", _on_interactive_area_entered)

func _process(delta: float) -> void:
	if is_being_moved_by_mouse:
		global_position = get_global_mouse_position()
	else:
		pass
		#print("NOT MOVED BY MOUSE ANYMORE")
		queue_free()

func _input(event: InputEvent) -> void:
	## TODO make same code lines work for all cases - need to rewrite the way it works, probably remove the usage of resources, and make it all work like it's working in the "item_holder" case.
	## Leave an item
	# If clicking at area where you can leave the item, the item is put there and removed from the previous cell, as while floating, it is the -1th child of its parent (prev cell).
	if event.is_action_pressed("left_click") and recent_cell_area and is_being_moved_by_mouse:
		var recent_cell = recent_cell_area.get_parent()
		if recent_cell.has_method("inventory_cell"):
			if inventory_resource.items[recent_cell.id] == null or inventory_resource.items[recent_cell.id] == "":
				# Using polymorphism, 
				inventory_resource.add_item(recent_cell.id, get_item_string())
				is_being_moved_by_mouse = false
		elif recent_cell.has_method("storage_cell"):
			var resource_to_put_in = recent_cell.resource
			if resource_to_put_in.items[recent_cell.id] == null or resource_to_put_in.items[recent_cell.id] == "":
				resource_to_put_in.add_item(recent_cell.id, get_item_string())
				is_being_moved_by_mouse = false
		elif recent_cell.has_method("item_holder"):
			await get_tree().process_frame
			print(">>>>> Putting the ", get_item_string())
			# Passing the item string so that the item name can be saved in the holder as well. The string is then converted into texture.
			recent_cell.set_item(get_item_string())
			is_being_moved_by_mouse = false

## !!! NOT WORKING THE INTENDED WAY, BUT MAY STILL BE ACCIDENTALLY CALLED AT RUNTIME, SO THE CODER IS NOTIFIED
func get_item_string() -> String:
	push_error("Method is intended to be called from the subclass, but was called from this class.")
	return get_class().to_lower()
