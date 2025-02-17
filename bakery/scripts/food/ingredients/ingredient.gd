class_name Ingredient extends Item

# The one currently hovering over with the item at mouse position
var recent_cell_area = null
var is_being_moved_by_mouse = false
var inventory_resource = preload("res://resources/gui/inventory_resource.tres")
var storage1_resource = preload("res://resources/objects/storage1_resource.tres")
var cooking_gui_resource = preload("res://resources/gui/cooking_gui_resource.tres")

func _ready() -> void:
	# Required when I instantiate and add the area at runtime,
	# but I decided to put it in the Ingredient scene manually
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
	# If at area where you can leave the item, 
	# the item is put there and removed from inventory cell 
	if event.is_action_pressed("left_click") and recent_cell_area and is_being_moved_by_mouse:
		var recent_cell = recent_cell_area.get_parent()
		if recent_cell.has_method("inventory_cell"):
			print("the cell has inventory_cell() method")
			if inventory_resource.items[recent_cell.id] == null or inventory_resource.items[recent_cell.id] == "":
				# Using polymorphism, 
				print("get_item_string() -> ", get_item_string())
				inventory_resource.add_item(recent_cell.id, get_item_string())
				is_being_moved_by_mouse = false
		elif recent_cell.has_method("storage_cell"):
			print("^ putting in a storage cell")
			var resource_to_put_in = recent_cell.resource
			if resource_to_put_in.items[recent_cell.id] == null or resource_to_put_in.items[recent_cell.id] == "":
				print("^ putting confirmed")
				resource_to_put_in.add_item(recent_cell.id, get_item_string())
				is_being_moved_by_mouse = false

func get_item_string() -> String:
	print("gettin string")
	return get_class().to_lower()
