class_name item_holder_data
extends Node


@export var ID : int


signal inventory_contents_changed(cell_id)
signal current_active_cell_changed(current_active_cell_id, current_active_cell_parent_id)


var storage_size = 1
var current_active_cell = -1


## "cell_id" - "item_scene_path" pair, both Strings
var storage : Dictionary = {}


func _ready() -> void:
	
	# Populate dictionary with default inventory empty values
	for i in range(storage_size):
		storage[i] = path_holder.EMPTY
		# FOR DEBUG TO FILL ALL STORAGE CELLS WITH BREAD
		#set_inventory_item(i, path_holder.CHERRY_CAKE_SCENE)


func set_inventory_item(cell_id : int, item_scene_path : String) -> void:
	if not (cell_id >= 0 and cell_id < storage_size):
		push_warning("Invalid cell_id")
	
	storage[str(cell_id)] = item_scene_path
	emit_signal("inventory_contents_changed", cell_id)


## Called from CellBase
func set_current_active_cell(cell_id : int):
	if not (cell_id >= -1 and cell_id < storage_size):
		push_warning("Invalid cell_id")
		return
	
	# If reseting the current active cell ids
	if cell_id == -1:
		client_ui_data.set_current_active_cell_id(cell_id, -1, path_holder.EMPTY)
	# Normal flow when setting existing cell id and data holder id
	else:
		client_ui_data.set_current_active_cell_id(cell_id, self.ID, get_inventory_item(cell_id))
	
	emit_signal("current_active_cell_changed", cell_id, ID)


func get_current_active_cell() -> int:
	return client_ui_data.get_current_active_cell_id()


## Returns item scene path stored in the specified cell
func get_inventory_item(cell_id : int) -> String:
	if storage.has(str(cell_id)):
		return storage[str(cell_id)]
	
	push_warning("Invalid cell id (", cell_id, ")")
	return path_holder.EMPTY


func get_inventory_dictionary() -> Dictionary:
	return storage


func get_id():
	return ID
