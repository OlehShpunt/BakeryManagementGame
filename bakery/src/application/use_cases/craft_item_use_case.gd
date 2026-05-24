class_name CraftItemUseCase
extends RefCounted

func execute(recipe: Array[Item], result_item: Item) -> void:
	var player_state := StateManager.get_player_state()

	# NOTE: It is okay that at this point we are not validating properly, because it is already validated at presentation layer by disabling/enabling the result item button
	for cell_state: CellState in player_state._player_cell_state_ref_registry.values():
		for recipe_item: Item in recipe:
			if recipe_item.is_equal(cell_state.item):
				cell_state.item = null
				recipe.erase(recipe_item)
				break

	assert(recipe.is_empty(), "Recipe must be empty. Most likely during rendering the result item button was enabled even though not all required items were in the inventory")

	var cid := player_state.get_first_empty_cell_state_id()
	player_state.set_inventory_item(cid, result_item)
