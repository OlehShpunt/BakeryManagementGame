class_name SellerState
extends RefCounted

var _id: int
var _seller_item_list: Item.ArrayOfItems

var seller_item_list: Item.ArrayOfItems:
	get():
		return _seller_item_list


func _init(seller_item_lists: SellerItemLists) -> void:
	print("//// random list: ", seller_item_lists.get_random())
	_seller_item_list = seller_item_lists.get_random()
	_id = randi()


func get_id() -> int:
	return _id
