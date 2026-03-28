class_name SellerItemLists
extends RefCounted

## Get a random list of items for any seller
static func get_random(seller_id: int) -> Item.ArrayOfItems:
	var lists: Array[Item.ArrayOfItems] = _get_all_lists_for_seller(seller_id)
	if lists.is_empty():
		push_error("SellerItemLists: No item lists defined for seller_id %d" % seller_id)
		return Item.ArrayOfItems.new([])

	return lists.pick_random()


## Get all possible item lists for a seller
static func get_all_lists(seller_id: int) -> Array[Item.ArrayOfItems]:
	return _get_all_lists_for_seller(seller_id)


static func _get_all_lists_for_seller(seller_id: int) -> Array[Item.ArrayOfItems]:
	match seller_id:
		# 1000 - Wholesale Shop
		1000:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, -5),
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Flour, 2),
					],
				),
			]

		# 2000 - Supermarket
		2000:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Milk, 1),
						_create_item(EnumHolder.ItemCode.Butter, 1),
						_create_item(EnumHolder.ItemCode.Chocolate, 1),
						_create_item(EnumHolder.ItemCode.Vanilla, 1),
						_create_item(EnumHolder.ItemCode.CocoaPowder, 1),
						_create_item(EnumHolder.ItemCode.Nuts, 1),
						_create_item(EnumHolder.ItemCode.Cherry, 1),
						_create_item(EnumHolder.ItemCode.Jello, 1),
					],
				),
			]

		# 3000 - Kiosk
		3000:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.CocoaPowder, -2),
						_create_item(EnumHolder.ItemCode.Jello, 0),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Vanilla, -1),
						_create_item(EnumHolder.ItemCode.Jello, 1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Vanilla, -1),
						_create_item(EnumHolder.ItemCode.CocoaPowder, -1),
						_create_item(EnumHolder.ItemCode.Jello, 0),
					],
				),
			]

		# 4000 - Mini Market
		4000:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Butter, -1),
						_create_item(EnumHolder.ItemCode.Vanilla, -1),
						_create_item(EnumHolder.ItemCode.CocoaPowder, 1),
						_create_item(EnumHolder.ItemCode.Nuts, 1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Chocolate, 1),
						_create_item(EnumHolder.ItemCode.CocoaPowder, -1),
						_create_item(EnumHolder.ItemCode.Nuts, 1),
						_create_item(EnumHolder.ItemCode.Cherry, 2),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Butter, 2),
						_create_item(EnumHolder.ItemCode.Chocolate, -1),
						_create_item(EnumHolder.ItemCode.Vanilla, 1),
						_create_item(EnumHolder.ItemCode.Cherry, 1),
						_create_item(EnumHolder.ItemCode.Jello, -2),
					],
				),
			]

		# 5000 - Street (Farmer Steve)
		5000:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, -1),
						_create_item(EnumHolder.ItemCode.Milk, 1),
						_create_item(EnumHolder.ItemCode.Butter, 0),
						_create_item(EnumHolder.ItemCode.Chocolate, -1),
						_create_item(EnumHolder.ItemCode.Cherry, 1),
						_create_item(EnumHolder.ItemCode.Nuts, 0),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Milk, -1),
						_create_item(EnumHolder.ItemCode.Butter, 1),
						_create_item(EnumHolder.ItemCode.Chocolate, 0),
						_create_item(EnumHolder.ItemCode.Cherry, -1),
						_create_item(EnumHolder.ItemCode.Nuts, 1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Milk, 0),
						_create_item(EnumHolder.ItemCode.Butter, -1),
						_create_item(EnumHolder.ItemCode.Chocolate, 1),
						_create_item(EnumHolder.ItemCode.Cherry, 0),
						_create_item(EnumHolder.ItemCode.Nuts, -1),
					],
				),
			]

		# 5001 - Street (Bazar seller Laura / Granny Laura)
		5001:
			return [
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Butter, -1),
						_create_item(EnumHolder.ItemCode.Cherry, -1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 2),
						_create_item(EnumHolder.ItemCode.Milk, -1),
						_create_item(EnumHolder.ItemCode.Nuts, -1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 1),
						_create_item(EnumHolder.ItemCode.Milk, -1),
						_create_item(EnumHolder.ItemCode.Butter, -1),
					],
				),
				Item.ArrayOfItems.new(
					[
						_create_item(EnumHolder.ItemCode.Flour, 0),
						_create_item(EnumHolder.ItemCode.Cherry, -1),
						_create_item(EnumHolder.ItemCode.Nuts, -1),
					],
				),
			]
		_:
			push_error("SellerItemLists: Unknown seller_id %d" % seller_id)
			return []


# Helper to create items
static func _create_item(code: EnumHolder.ItemCode, default_sale_price_modifier: int) -> Item:
	var item := Item.new(code)
	item.sale_price += default_sale_price_modifier
	return item
