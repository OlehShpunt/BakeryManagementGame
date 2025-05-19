extends Node


var sellers_JSON_path = "res://resources/json/sellers.json"


func generate_item_list_for_all_sellers():
	var file = FileAccess.open(sellers_JSON_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var sellers = data["sellers"]
	
	for seller_id in sellers:
		generate_item_list_for(seller_id)


func generate_item_list_for(seller_id):
	var file = FileAccess.open(sellers_JSON_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var sellers = data["sellers"]
	var target_seller = sellers[str(seller_id)]
	
	# "0" : {Array[Strings of item_path]}, "1" : {...}, "2"...
	var possible_shop_items : Dictionary = target_seller[str("possible_shop_items")]
	
	var possible_shop_items_size : int = possible_shop_items.size()
	
	if possible_shop_items_size < 1:
		push_warning("Could not generate (randomly pick) item list, because the size of possible_shop_items is invalid")
		return
	
	var picked_index = randi_range(0, possible_shop_items_size - 1)
	
	## DEBUG
	print("& picked Array[String] shop_items list for ", seller_id, ": \n", possible_shop_items[str(picked_index)], "\n\n")
	print("Type of an element of Array possible_shop_items = ", typeof(possible_shop_items[str(picked_index)][0]))
	
	for item in possible_shop_items[str(picked_index)]:
		print("Type of {", item, "} of Array possible_shop_items = ", typeof(item))
	
	client_ui_data.update_seller(seller_id, possible_shop_items[str(picked_index)])
	assign_item_list(seller_id, possible_shop_items[str(picked_index)])


## Assigns shop_items (item list) to the specified Seller
## @param new_item_list - Array[String] with format "item_path, price_as_integer" - list of items to be sold being assigned to the seller
func assign_item_list(seller_id, new_item_list : Array) -> void:
	var seller_ref : SellerBase = global_ref_register.get_seller_ref(seller_id)
	
	if seller_ref == null:
		push_warning("Could not assign item list to null value, so function execution halted")
		return
	
	seller_ref.set_shop_items(new_item_list)
