extends Control

const crafting_menu_row_preload: PackedScene = preload("res://src/presentation/item/crafting/crafting_menu_row.tscn")
@onready var rows_container: VBoxContainer = $PanelContainer/VBoxContainer/MarginContainer2/ScrollContainer/VBoxContainer


func _ready() -> void:
	rerender([])
	var player_state: PlayerState = StateManager.get_player_state()
	player_state.player_inventory_updated.connect(rerender)


func rerender(items_in_inventory: Array[Item]) -> void:
	for child in rows_container.get_children():
		child.queue_free()

	print("crafting menu rerender called")
	# TODO: Optimize
	for item_code: int in EnumHolder.ItemCode.values():
		print("bams ", item_code)
		# Need to copy so that Items are not erased for new row
		var items_in_inventory_copy = items_in_inventory.duplicate_deep()
		var recipeItemCodes: Array[EnumHolder.ItemCode] = Recipes.get_recipe_by_item_code(item_code)
		var recipe: Array[Item] = []
		for code in recipeItemCodes:
			var item_found_in_inventory = false

			for item in items_in_inventory_copy:
				if item.item_code == code:
					items_in_inventory_copy.erase(item)
					recipe.append(item)
					item_found_in_inventory = true
					break

			# If not in items_in_inventory_copy
			if not item_found_in_inventory:
				recipe.append(Item.new(code))

		var result_item: Item = Item.new(item_code)
		var result: Dictionary = CraftingMenuRow.create(recipe, result_item)

		if (result.get("success")):
			var crafting_menu_row_instance: CraftingMenuRow = result.get("row")
			rows_container.add_child(crafting_menu_row_instance)
		else:
			pass

	#func check_item_availability(recipe: Array[Item]) -> void:
	#var player_state: PlayerState = StateManager.get_player_state()
	#player_state.player_inventory_updated.connect()


class Recipe:
	var name: String
	var ingredients: Array
	var result: String

# func get_image_path_for_item(item_key: String) -> String:
# 	match item_key:
# 		"flour":
# 			return PathHolder.FLOUR_IMAGE
# 		"milk":
# 			return PathHolder.MILK_IMAGE
# 		"butter":
# 			return PathHolder.BUTTER_IMAGE
# 		"chocolate":
# 			return PathHolder.CHOCOLATE_IMAGE
# 		"vanilla":
# 			return PathHolder.VANILLA_IMAGE
# 		"cocoa_powder":
# 			return PathHolder.COCOA_IMAGE
# 		"nuts":
# 			return PathHolder.NUTS_IMAGE
# 		"cherry":
# 			return PathHolder.CHERRY_IMAGE
# 		"jello":
# 			return PathHolder.JELLO_IMAGE
# 		"bread":
# 			return PathHolder.BREAD_IMAGE
# 		"bagel":
# 			return PathHolder.BAGEL_IMAGE
# 		"waffle":
# 			return PathHolder.WAFFLE_IMAGE
# 		"sponge_cake":
# 			return PathHolder.SPONGE_CAKE_IMAGE
# 		"donut":
# 			return PathHolder.DONUT_IMAGE
# 		"chocolate_candy":
# 			return PathHolder.CHOCOLATE_CANDY_IMAGE
# 		"signature_chocolate":
# 			return PathHolder.SIGNATURE_CHOCOLATE_IMAGE
# 		"pudding":
# 			return PathHolder.PUDDING_IMAGE
# 		"chocolate_bun":
# 			return PathHolder.CHOCOLATE_BUN_IMAGE
# 		"muffin":
# 			return PathHolder.MUFFIN_IMAGE
# 		"nut_candy":
# 			return PathHolder.NUT_CANDY_IMAGE
# 		"cookie":
# 			return PathHolder.COOKIE_IMAGE
# 		"nut_cake":
# 			return PathHolder.NUT_CAKE_IMAGE
# 		"cherry_cake":
# 			return PathHolder.CHERRY_CAKE_IMAGE
# 		_:
# 			push_warning("Unknown item key: " + item_key)
# 			return ""

# func get_item_code_for_item(item_key: String) -> EnumHolder.ItemCode:
# 	match item_key:
# 		"flour":
# 			return EnumHolder.ItemCode.Flour
# 		"milk":
# 			return EnumHolder.ItemCode.Milk
# 		"butter":
# 			return EnumHolder.ItemCode.Butter
# 		"chocolate":
# 			return EnumHolder.ItemCode.Chocolate
# 		"vanilla":
# 			return EnumHolder.ItemCode.Vanilla
# 		"cocoa_powder":
# 			return EnumHolder.ItemCode.CocoaPowder
# 		"nuts":
# 			return EnumHolder.ItemCode.Nuts
# 		"cherry":
# 			return EnumHolder.ItemCode.Cherry
# 		"jello":
# 			return EnumHolder.ItemCode.Jello
# 		"bread":
# 			return EnumHolder.ItemCode.Bread
# 		"bagel":
# 			return EnumHolder.ItemCode.Bagel
# 		"waffle":
# 			return EnumHolder.ItemCode.Waffle
# 		"sponge_cake":
# 			return EnumHolder.ItemCode.SpongeCake
# 		"donut":
# 			return EnumHolder.ItemCode.Donut
# 		"chocolate_candy":
# 			return EnumHolder.ItemCode.ChocolateCandy
# 		"signature_chocolate":
# 			return EnumHolder.ItemCode.SignatureChocolate
# 		"pudding":
# 			return EnumHolder.ItemCode.Pudding
# 		"chocolate_bun":
# 			return EnumHolder.ItemCode.ChocolateBun
# 		"muffin":
# 			return EnumHolder.ItemCode.Muffin
# 		"nut_candy":
# 			return EnumHolder.ItemCode.NutCandy
# 		"cookie":
# 			return EnumHolder.ItemCode.Cookie
# 		"nut_cake":
# 			return EnumHolder.ItemCode.NutCake
# 		"cherry_cake":
# 			return EnumHolder.ItemCode.CherryCake
# 		_:
# 			push_warning("Unknown item key: " + item_key)
# 			return -1
