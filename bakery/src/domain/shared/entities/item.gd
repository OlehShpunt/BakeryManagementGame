class_name Item
extends RefCounted

var _item_code: EnumHolder.ItemCode
var _name: String
var _texture: Texture2D
var _cost_price: int
var _sale_price: int
var _required_items: Array[EnumHolder.ItemCode]

var item_code: EnumHolder.ItemCode:
	set(code):
		_item_code = code
	get():
		return _item_code

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

var required_items: Array[EnumHolder.ItemCode]:
	get():
		return _required_items
	set(value):
		_required_items = value

var _default_cost_price: Dictionary[EnumHolder.ItemCode, int] = {
	EnumHolder.ItemCode.Bread: 0,
	EnumHolder.ItemCode.Waffle: 0,
	EnumHolder.ItemCode.SpongeCake: 0,
	EnumHolder.ItemCode.Donut: 0,
	EnumHolder.ItemCode.ChocolateCandy: 0,
	EnumHolder.ItemCode.SignatureChocolate: 0,
	EnumHolder.ItemCode.Pudding: 0,
	EnumHolder.ItemCode.ChocolateBun: 0,
	EnumHolder.ItemCode.Muffin: 0,
	EnumHolder.ItemCode.NutCandy: 0,
	EnumHolder.ItemCode.Cookie: 0,
	EnumHolder.ItemCode.NutCake: 0,
	EnumHolder.ItemCode.CherryCake: 0,
	EnumHolder.ItemCode.Bagel: 0,
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
	EnumHolder.ItemCode.Bread: 15,
	EnumHolder.ItemCode.Waffle: 15,
	EnumHolder.ItemCode.SpongeCake: 15,
	EnumHolder.ItemCode.Donut: 15,
	EnumHolder.ItemCode.ChocolateCandy: 15,
	EnumHolder.ItemCode.SignatureChocolate: 15,
	EnumHolder.ItemCode.Pudding: 15,
	EnumHolder.ItemCode.ChocolateBun: 15,
	EnumHolder.ItemCode.Muffin: 15,
	EnumHolder.ItemCode.NutCandy: 15,
	EnumHolder.ItemCode.Cookie: 15,
	EnumHolder.ItemCode.NutCake: 15,
	EnumHolder.ItemCode.CherryCake: 15,
	EnumHolder.ItemCode.Bagel: 15,
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
	EnumHolder.ItemCode.Waffle: "Waffle",
	EnumHolder.ItemCode.SpongeCake: "Sponge Cake",
	EnumHolder.ItemCode.Donut: "Donut",
	EnumHolder.ItemCode.ChocolateCandy: "Chocolate Candy",
	EnumHolder.ItemCode.SignatureChocolate: "Signature Chocolate",
	EnumHolder.ItemCode.Pudding: "Pudding",
	EnumHolder.ItemCode.ChocolateBun: "Chocolate Bun",
	EnumHolder.ItemCode.Muffin: "Muffin",
	EnumHolder.ItemCode.NutCandy: "Nut Candy",
	EnumHolder.ItemCode.Cookie: "Cookie",
	EnumHolder.ItemCode.NutCake: "Nut Cake",
	EnumHolder.ItemCode.CherryCake: "Cherry Cake",
	EnumHolder.ItemCode.Bagel: "Bagel",
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
	EnumHolder.ItemCode.Bagel: load(TEXTURE_BASE_PATH + "bagel.png"),
	EnumHolder.ItemCode.Waffle: load(TEXTURE_BASE_PATH + "waffle.png"),
	EnumHolder.ItemCode.SpongeCake: load(TEXTURE_BASE_PATH + "sponge_cake.png"),
	EnumHolder.ItemCode.Donut: load(TEXTURE_BASE_PATH + "donut.png"),
	EnumHolder.ItemCode.ChocolateCandy: load(TEXTURE_BASE_PATH + "chocolate_candy.png"),
	EnumHolder.ItemCode.SignatureChocolate: load(TEXTURE_BASE_PATH + "signature_chocolate.png"),
	EnumHolder.ItemCode.Pudding: load(TEXTURE_BASE_PATH + "pudding.png"),
	EnumHolder.ItemCode.ChocolateBun: load(TEXTURE_BASE_PATH + "chocolate_bun.png"),
	EnumHolder.ItemCode.Muffin: load(TEXTURE_BASE_PATH + "muffin.png"),
	EnumHolder.ItemCode.NutCandy: load(TEXTURE_BASE_PATH + "nut_candy.png"),
	EnumHolder.ItemCode.Cookie: load(TEXTURE_BASE_PATH + "cookie.png"),
	EnumHolder.ItemCode.NutCake: load(TEXTURE_BASE_PATH + "nut_cake.png"),
	EnumHolder.ItemCode.CherryCake: load(TEXTURE_BASE_PATH + "cherry_cake.png"),
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


# Inside your Item class
static func get_required_items(item_code: EnumHolder.ItemCode) -> Array[EnumHolder.ItemCode]:
	match item_code:
		EnumHolder.ItemCode.Bread:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Flour]
		EnumHolder.ItemCode.Bagel:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk]
		EnumHolder.ItemCode.Waffle:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Chocolate]
		EnumHolder.ItemCode.SpongeCake:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Vanilla]
		EnumHolder.ItemCode.Donut:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Chocolate]
		EnumHolder.ItemCode.ChocolateCandy:
			return [EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Chocolate, EnumHolder.ItemCode.CocoaPowder]
		EnumHolder.ItemCode.SignatureChocolate:
			return [EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Chocolate, EnumHolder.ItemCode.Vanilla]
		EnumHolder.ItemCode.Pudding:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Vanilla, EnumHolder.ItemCode.Jello]
		EnumHolder.ItemCode.ChocolateBun:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Chocolate, EnumHolder.ItemCode.Vanilla, EnumHolder.ItemCode.Vanilla]
		EnumHolder.ItemCode.Muffin:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Cherry]
		EnumHolder.ItemCode.NutCandy:
			return [EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Nuts]
		EnumHolder.ItemCode.Cookie:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Chocolate, EnumHolder.ItemCode.Nuts]
		EnumHolder.ItemCode.NutCake:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.CocoaPowder, EnumHolder.ItemCode.Nuts]
		EnumHolder.ItemCode.CherryCake:
			return [EnumHolder.ItemCode.Flour, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Milk, EnumHolder.ItemCode.Butter, EnumHolder.ItemCode.Cherry, EnumHolder.ItemCode.Jello]
		_:
			return []


func _init(item_enum_code: EnumHolder.ItemCode, item_cost_price: int = -999, item_sale_price: int = -999) -> void:
	self.item_code = item_enum_code

	if (item_cost_price == -999):
		_cost_price = _default_cost_price.get(item_code)
	else:
		_cost_price = item_cost_price

	if (item_sale_price == -999):
		_sale_price = _default_sale_price.get(item_code)
	else:
		_sale_price = item_sale_price

	_required_items = get_required_items(item_code)

	_name = _name_mapper.get(item_code)
	_texture = _texture_mapper.get(item_code)


func is_equal(item: Item) -> bool:
	if (self.item_code == item.item_code and self.cost_price == item.cost_price and self.sale_price == item.sale_price):
		return true

	return false


class ArrayOfItems:
	var _value: Array[Item]


	func _init(items: Array[Item]) -> void:
		_value = items


	func get_array() -> Array[Item]:
		return _value


	func add(item: Item) -> void:
		_value.append(item)
