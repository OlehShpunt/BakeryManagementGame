class_name SellerUiItemRowState
extends RefCounted

signal is_sold_updated(is_sold: bool)

var _seller_id: int
var _row_id: int
var _item: Item
var _is_sold: bool

var seller_id: int:
	get():
		return _seller_id
	set(value):
		_seller_id = value

var row_id: int:
	get():
		return _row_id
	set(value):
		_row_id = value

var item: Item:
	get():
		return _item
	set(value):
		_item = value

var is_sold: bool:
	get():
		return _is_sold
	set(value):
		_is_sold = value
		is_sold_updated.emit(value)
