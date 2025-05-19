extends Node

#var debug = 0
#func _process(delta: float) -> void:
	#debug = debug + 1
	#if debug > 1000:
		#seller_item_list_generator.generate_item_list_for_all_sellers()
		#debug = 0
		#print("AGAIN NOW")


## PLAYER UI DATA

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


func get_current_active_cell_id() -> int:
	return current_active_cell_id


func get_current_active_cell_data_holder_id() -> int:
	return current_active_cell_data_holder_id


func register_data_holder(data_holder_id, data_holder_reference):
	# If already registered, just reassign the existing value to the passed data_holder_reference
	if registered_data_holders.has(str(data_holder_id)):
		pass
		#data_holder_reference = registered_data_holders[str(data_holder_id)]
	else:
		registered_data_holders[str(data_holder_id)] = data_holder_reference


func is_data_holder_registered(data_holder_id):
	if registered_data_holders.has(str(data_holder_id)):
		return registered_data_holders[str(data_holder_id)]
	else:
		return ERR_DOES_NOT_EXIST


## SELLER DATA

signal sellers_data_updated(seller_id : String)
signal seller_data_initialization_success
signal seller_data_initialization_failure


## Format: "seller_id" : [Array[String]] with "item_path,price,isSold"
var sellers_data : Dictionary = {}
var sellers_JSON_path = "res://resources/json/sellers.json"


## At the start of game
## Saves data on server only
## Adds the registered seller IDs to the dictionary
func initialize_seller_data():
	
	## Save data on server only
	if get_multiplayer_authority() != 1:
		return
	
	var file = FileAccess.open(sellers_JSON_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var sellers = data["sellers"]
	
	# seller_id is a String integer
	for seller_id in sellers:
		# fill with a placeholder
		update_seller(seller_id, [])
	
	emit_signal("seller_data_initialization_success")
	
	return 0


## Sets sellers data (all seller_ids)
## @param new_sellers_data consists of "seller_id" - Array[String] key-value pairs,
## where Array[String] has Strings formatted as "item_path,price,isSold"
func update_all_sellers(new_sellers_data : Dictionary) -> void:
	for seller_id in new_sellers_data:
		if self.sellers_data.has(str(seller_id)):
			update_seller(seller_id, new_sellers_data[str(seller_id)])
		else:
			push_warning("Seller id is not found in sellers_data (id = ", seller_id, ")")


## Sets shop_items for each seller_id
## Mutator to change the shop_items list (normally for keeping track of sold items to send rpcs to other clients)
## Format for shop_items single item is "item_path:String, priceInt:int, isSoldOut:bool":String
func update_seller(seller_id : String, shop_items : Array) -> void:
	self.sellers_data[seller_id] = shop_items
	emit_signal("sellers_data_updated", seller_id)  # seller_id : String


## Returns sellers_data
func get_sellers_data() -> Dictionary:
	return sellers_data


## Returns shop_items Array[String] for specific seller_id
func get_seller_shop_items(seller_id : String):
	if sellers_data.has(seller_id):
		return sellers_data[seller_id]
	else:
		# The key is not in the array
		return ERR_DOES_NOT_EXIST
