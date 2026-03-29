class_name CellState
extends RefCounted

signal item_updated(item: Item)

var _item: Item

var item: Item:
	set(item):
		_item = item
		print("item updated!!!!!!! emitting signal")
		item_updated.emit(_item)
	get():
		return _item


func _init() -> void:
	pass
