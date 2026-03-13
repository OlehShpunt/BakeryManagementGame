class_name player_data
extends Node


## IF of player_data holder
const ID = 1000

var balance = 15


signal inventory_contents_changed(cell_id)
signal current_active_cell_changed(current_active_cell_id, current_active_cell_parent_id)


var inventory_size = 4


## "cell_id" - "item_scene_path" pair, both Strings
var inventory : Dictionary = {}


func _ready() -> void:
	# Populate default inventory empty values
	for i in range(inventory_size):
		inventory[i] = path_holder.EMPTY


func set_inventory_item(cell_id : int, item_scene_path : String) -> void:
	if not (cell_id >= 0 and cell_id < inventory_size):
		push_warning("Invalid cell_id")
		return
	
	inventory[str(cell_id)] = item_scene_path
	
	emit_signal("inventory_contents_changed", cell_id)


func set_current_active_cell(cell_id : int):
	if not (cell_id >= -1 and cell_id < inventory_size):
		push_warning("Invalid cell_id")
		return

	
	# If reseting the current active cell ids
	if cell_id == -1:
		client_ui_data.set_current_active_cell_id(cell_id, -1, path_holder.EMPTY)
	# Normal flow when setting existing cell id and data holder id
	else:
		client_ui_data.set_current_active_cell_id(cell_id, self.ID, get_inventory_item(cell_id))
		print("* setting current active cell to ", cell_id, " with parent ", ID)
		#client_ui_data.current_active_cell = cell_id
		emit_signal("current_active_cell_changed", cell_id, ID)


func get_current_active_cell() -> int:
	return client_ui_data.get_current_active_cell_id()


## Returns item scene path stored in the specified cell
func get_inventory_item(cell_id : int) -> String:
	if not (cell_id >= 0 and cell_id < inventory_size):
		push_warning("Trying to access cell with invalid id")
		return path_holder.EMPTY
	
	if inventory.has(str(cell_id)):
		return inventory[str(cell_id)]
	
	push_warning("Invalid cell id (", cell_id, ")")
	return path_holder.EMPTY


func get_inventory_dictionary() -> Dictionary:
	return inventory


func get_id():
	return ID
