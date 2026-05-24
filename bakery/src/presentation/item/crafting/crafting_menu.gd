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
		var items_in_inventory_copy: Array[Item] = items_in_inventory.duplicate_deep()
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
				var placeholder_item = Item.new(code)
				# NOTE: -10 means that this item is not in player inventory, so make it inactive (show NotInInventory panel)
				placeholder_item.cost_price = -10
				recipe.append(placeholder_item)

		var result_item: Item = Item.new(item_code)
		var result: Dictionary = CraftingMenuRow.create(recipe, result_item)

		if (result.get("success")):
			var crafting_menu_row_instance: CraftingMenuRow = result.get("row")
			rows_container.add_child(crafting_menu_row_instance)
		else:
			pass
