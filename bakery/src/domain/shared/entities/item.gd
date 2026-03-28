class_name Item
extends RefCounted

var _item_code: EnumHolder.ItemCode
var _name: String
var _texture: Texture2D
var _cost_price: int
var _sale_price: int

var name: String:
	set(name):
		_name = name
	get:
		return _name
var texture: Texture2D:
	set(texture):
		_texture = texture
	get:
		return _texture
var cost_price: int:
	set(cost_price):
		_cost_price = cost_price
	get:
		return _cost_price
var sale_price: int:
	set(sale_price):
		_sale_price = sale_price
	get:
		return _sale_price

var _default_cost_price: Dictionary[EnumHolder.ItemCode, int] = {
	EnumHolder.ItemCode.Bread: 0,
	EnumHolder.ItemCode.Flour: 0,
	EnumHolder.ItemCode.Milk: 0,
	EnumHolder.ItemCode.Butter: 0,
	EnumHolder.ItemCode.Chocolate: 0,
	EnumHolder.ItemCode.Vanilla: 0,
	EnumHolder.ItemCode.CocoaPowder: 0,
	EnumHolder.ItemCode.Nuts: 0,
	EnumHolder.ItemCode.Cherry: 0,
	EnumHolder.ItemCode.Jello: 0,
}

var _default_sale_price: Dictionary[EnumHolder.ItemCode, int] = {
	EnumHolder.ItemCode.Bread: 15, # test price
	EnumHolder.ItemCode.Flour: 1,
	EnumHolder.ItemCode.Milk: 2,
	EnumHolder.ItemCode.Butter: 3,
	EnumHolder.ItemCode.Chocolate: 2,
	EnumHolder.ItemCode.Vanilla: 2,
	EnumHolder.ItemCode.CocoaPowder: 3,
	EnumHolder.ItemCode.Nuts: 4,
	EnumHolder.ItemCode.Cherry: 3,
	EnumHolder.ItemCode.Jello: 4,
}

var _name_mapper: Dictionary[EnumHolder.ItemCode, String] = {
	EnumHolder.ItemCode.Bread: "Bread",
	EnumHolder.ItemCode.Flour: "Flour",
	EnumHolder.ItemCode.Milk: "Milk",
	EnumHolder.ItemCode.Butter: "Butter",
	EnumHolder.ItemCode.Chocolate: "Chocolate",
	EnumHolder.ItemCode.Vanilla: "Vanilla",
	EnumHolder.ItemCode.CocoaPowder: "Cocoa Powder",
	EnumHolder.ItemCode.Nuts: "Nuts",
	EnumHolder.ItemCode.Cherry: "Cherry",
	EnumHolder.ItemCode.Jello: "Jello",
}

static var TEXTURE_BASE_PATH: String = "res://assets/ingredientsPNG/"

var _texture_mapper: Dictionary[EnumHolder.ItemCode, Texture2D] = {
	EnumHolder.ItemCode.Bread: load(TEXTURE_BASE_PATH + "bread.png"),
	EnumHolder.ItemCode.Flour: load(TEXTURE_BASE_PATH + "flour.png"),
	EnumHolder.ItemCode.Milk: load(TEXTURE_BASE_PATH + "milk.png"),
	EnumHolder.ItemCode.Butter: load(TEXTURE_BASE_PATH + "butter.png"),
	EnumHolder.ItemCode.Chocolate: load(TEXTURE_BASE_PATH + "chocolate.png"),
	EnumHolder.ItemCode.Vanilla: load(TEXTURE_BASE_PATH + "vanilla.png"),
	EnumHolder.ItemCode.CocoaPowder: load(TEXTURE_BASE_PATH + "cocoa_powder.png"),
	EnumHolder.ItemCode.Nuts: load(TEXTURE_BASE_PATH + "nuts.png"),
	EnumHolder.ItemCode.Cherry: load(TEXTURE_BASE_PATH + "cherry.png"),
	EnumHolder.ItemCode.Jello: load(TEXTURE_BASE_PATH + "jello.png"),
}


func _init(item_code: EnumHolder.ItemCode, cost_price: int = -999, sale_price: int = -999) -> void:
	if (cost_price == -999):
		_cost_price = _default_cost_price.get(item_code)
	else:
		_cost_price = cost_price

	if (sale_price == -999):
		_sale_price = _default_sale_price.get(item_code)
	else:
		_sale_price = sale_price

	_name = _name_mapper.get(item_code)
	_texture = _texture_mapper.get(item_code)


class ArrayOfItems:
	var _value: Array[Item]


	func _init(items: Array[Item]) -> void:
		_value = items


	func get_array() -> Array[Item]:
		return _value


	func add(item: Item):
		_value.append(item)
