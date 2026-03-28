class_name SellerState
extends RefCounted

var _id: int
var _seller_item_list: Item.ArrayOfItems

var seller_item_list: Item.ArrayOfItems:
	get():
		return _seller_item_list


func _init(seller_id: int) -> void:
	_id = seller_id
	_seller_item_list = SellerItemLists.get_random(seller_id)


func get_id() -> int:
	return _id
