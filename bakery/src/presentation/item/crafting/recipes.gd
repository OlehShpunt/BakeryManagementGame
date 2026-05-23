class_name Recipes
extends RefCounted

static func get_recipe_by_item_code(code: EnumHolder.ItemCode) -> Array[EnumHolder.ItemCode]:
	match code:
		EnumHolder.ItemCode.Bread:
			return get_bread_recipe()
		EnumHolder.ItemCode.Bagel:
			return get_bagel_recipe()
		EnumHolder.ItemCode.Waffle:
			return get_waffle_recipe()
		EnumHolder.ItemCode.SpongeCake:
			return get_sponge_cake_recipe()
		EnumHolder.ItemCode.Donut:
			return get_donut_recipe()
		EnumHolder.ItemCode.ChocolateCandy:
			return get_chocolate_candy_recipe()
		EnumHolder.ItemCode.SignatureChocolate:
			return get_signature_chocolate_recipe()
		EnumHolder.ItemCode.Pudding:
			return get_pudding_recipe()
		EnumHolder.ItemCode.ChocolateBun:
			return get_chocolate_bun_recipe()
		EnumHolder.ItemCode.Muffin:
			return get_muffin_recipe()
		EnumHolder.ItemCode.NutCandy:
			return get_nut_candy_recipe()
		EnumHolder.ItemCode.Cookie:
			return get_cookie_recipe()
		EnumHolder.ItemCode.NutCake:
			return get_nut_cake_recipe()
		EnumHolder.ItemCode.CherryCake:
			return get_cherry_cake_recipe()
		_:
			return []


static func get_bread_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Flour,
	]


static func get_bagel_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
	]


static func get_waffle_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Chocolate,
	]


static func get_sponge_cake_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Vanilla,
	]


static func get_donut_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Chocolate,
	]


static func get_chocolate_candy_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Chocolate,
		EnumHolder.ItemCode.CocoaPowder,
	]


static func get_signature_chocolate_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Chocolate,
		EnumHolder.ItemCode.Vanilla,
	]


static func get_pudding_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Vanilla,
		EnumHolder.ItemCode.Jello,
	]


static func get_chocolate_bun_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Chocolate,
		EnumHolder.ItemCode.Vanilla,
		EnumHolder.ItemCode.Vanilla,
	]


static func get_muffin_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Cherry,
	]


static func get_nut_candy_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Nuts,
	]


static func get_cookie_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Chocolate,
		EnumHolder.ItemCode.Nuts,
	]


static func get_nut_cake_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.CocoaPowder,
		EnumHolder.ItemCode.Nuts,
	]


static func get_cherry_cake_recipe() -> Array[EnumHolder.ItemCode]:
	return [
		EnumHolder.ItemCode.Flour,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Milk,
		EnumHolder.ItemCode.Butter,
		EnumHolder.ItemCode.Cherry,
		EnumHolder.ItemCode.Jello,
	]
