class_name SellerState
extends RefCounted

var _seller_id: int
var _seller_item_list: Dictionary[int, SellerUiItemRowState]

var seller_item_list: Dictionary[int, SellerUiItemRowState]:
	get():
		return _seller_item_list


func _init(seller_id: int) -> void:
	_seller_id = seller_id
	var items_array := SellerItemLists.get_random(seller_id)
	_seller_item_list = PresentationUtils.items_array_to_dict(items_array, seller_id)


func get_seller_id() -> int:
	return _seller_id
