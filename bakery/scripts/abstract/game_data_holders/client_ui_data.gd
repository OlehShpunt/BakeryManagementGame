extends Node


signal client_current_active_cell_changed(cell_id, parent_id)

signal client_current_data_changed_from_to(from_cell_id, from_parent_id, from_cell_data, to_cell_id, to_parent_id, to_cell_data)


## ID of the current active cell
var current_active_cell_id = -1
## ID of data holder that is associated with the cell
var current_active_cell_data_holder_id = -1
## path of current chosen item
var item_at_current_active_cell = path_holder.EMPTY


var registered_data_holders : Dictionary = {}


func set_current_active_cell_id(new_cell_id, new_cell_data_holder_id, new_current_item):

	var can_move_item : bool = true
	
	# Saving the previous active cell's related values for moving items (see code later)
	var prev_cell_id = current_active_cell_id
	var prev_cell_data_holder_id = current_active_cell_data_holder_id
	var prev_current_item = item_at_current_active_cell
	
	# Updating new active cell's values with this function's arguments
	current_active_cell_id = new_cell_id
	current_active_cell_data_holder_id = new_cell_data_holder_id
	item_at_current_active_cell = new_current_item
	
	# If certain conditions are met, move the previous item from the previous cell to the new selected cell
	if new_cell_id != -1 and \
	   prev_cell_id != -1 and \
	   # Previous cell must have some item and new cell must have no item
	   prev_current_item != path_holder.EMPTY and \
	   new_current_item == path_holder.EMPTY:
		
		# Get reference to the previous cell's data holder reference to modify its contents (remove item from the cell)
		if not registered_data_holders.has(str(prev_cell_data_holder_id)):
			push_error("Could not get a reference of the previous cell's data holder")
		var prev_cell_data_ref = registered_data_holders[str(prev_cell_data_holder_id)]
		
		# Get reference to the new cell's data holder reference to modify its contents (add new item)
		if not registered_data_holders.has(str(new_cell_data_holder_id)):
			push_error("Could not get a reference of the previous cell's data holder")
		var new_cell_data_ref = registered_data_holders[str(new_cell_data_holder_id)]
		
		# Move the item from previous cell to new cell
		prev_cell_data_ref.set_inventory_item(prev_cell_id, path_holder.EMPTY)
		new_cell_data_ref.set_inventory_item(new_cell_id, prev_current_item)
		
		# Deactivate any selected cell
		call_deferred("set_current_active_cell_id", -1, -1, path_holder.EMPTY)
	
	emit_signal("client_current_active_cell_changed", new_cell_id, new_cell_data_holder_id)
	
	# DEPRECATED
	#if not do_not_emit:
		#emit_signal("client_current_data_changed_from_to", from_current_active_cell_id, from_current_active_cell_data_holder_id, from_cell_data, current_active_cell_id, current_active_cell_data_holder_id, to_cell_data)


func justTesting():
	pass

func get_current_active_cell_id() -> int:
	return current_active_cell_id


func get_current_active_cell_data_holder_id() -> int:
	return current_active_cell_data_holder_id


func register_data_holder(data_holder_id, data_holder_reference):
	registered_data_holders[str(data_holder_id)] = data_holder_reference


func is_data_holder_registered(data_holder_id) -> bool:
	if registered_data_holders.has(str(data_holder_id)):
		return true
	else:
		return false
