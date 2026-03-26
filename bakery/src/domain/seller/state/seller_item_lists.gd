class_name SellerItemLists
extends RefCounted

var _items: Array[Item.ArrayOfItems] = []


func _init() -> void:
	_items = [Item.ArrayOfItems.new([Item.new(EnumHolder.ItemCode.Bread, 10, 15), Item.new(EnumHolder.ItemCode.Bread, 10, 15), Item.new(EnumHolder.ItemCode.Bread, 10, 15)])]


func get_random() -> Item.ArrayOfItems:
	return _items.pick_random()
