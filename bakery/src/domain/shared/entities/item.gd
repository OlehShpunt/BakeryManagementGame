class_name Item
extends RefCounted

var _item_code: EnumHolder.ItemCode
var _name: String
var _texture: Texture2D
var _cost_price: int
var _sale_price: int

var name: String:
	get:
		return _name
var texture: Texture2D:
	get:
		return _texture
var cost_price: int:
	get:
		return _cost_price
var sale_price: int:
	get:
		return _sale_price

var _default_cost_price: Dictionary[EnumHolder.ItemCode, int] = {
	EnumHolder.ItemCode.Bread: 10,
}

var _default_sale_price: Dictionary[EnumHolder.ItemCode, int] = {
	EnumHolder.ItemCode.Bread: 15,
}

var _name_mapper: Dictionary[EnumHolder.ItemCode, String] = {
	EnumHolder.ItemCode.Bread: "Bread",
}

var _texture_mapper: Dictionary[EnumHolder.ItemCode, Texture2D] = {
	EnumHolder.ItemCode.Bread: load("res://assets/ingredientsPNG/bread.png"),
}


func _init(item_code: EnumHolder.ItemCode, cost_price: int = -1, sale_price: int = -1) -> void:
	if (cost_price == -1):
		_cost_price = _default_cost_price.get(EnumHolder.ItemCode.Bread)

	if (sale_price == -1):
		_sale_price = _default_sale_price.get(EnumHolder.ItemCode.Bread)

	if (item_code == EnumHolder.ItemCode.Bread):
		_name = _name_mapper.get(EnumHolder.ItemCode.Bread)
		_texture = _texture_mapper.get(EnumHolder.ItemCode.Bread)
		_cost_price = cost_price


class ArrayOfItems:
	var _value: Array[Item]


	func _init(items: Array[Item]) -> void:
		_value = items


	func get_array() -> Array[Item]:
		return _value


	func add(item: Item):
		_value.append(item)
