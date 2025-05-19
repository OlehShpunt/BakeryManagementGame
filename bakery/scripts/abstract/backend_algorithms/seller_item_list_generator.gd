extends Node


var sellers_JSON_path = "res://resources/json/sellers.json"


func generate_item_list(seller_id):
	var file = FileAccess.open(sellers_JSON_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var sellers = data["sellers"]
	var target_seller = sellers[str(seller_id)]
	var possible_shop_items = target_seller[str("possible_shop_items")]


## @param list - Array[String] with format "item_path, price_as_integer" - list of items to be sold being assigned to the seller
func assign_item_list(new_item_list : Array[String], seller_id) -> void:
	var seller_ref : SellerBase = global_ref_register.get_seller_ref(seller_id)
	
	if seller_ref == null:
		push_warning("Could not assign item list to null value, so function execution halted")
		return
	
	seller_ref.set_shop_items(new_item_list)
