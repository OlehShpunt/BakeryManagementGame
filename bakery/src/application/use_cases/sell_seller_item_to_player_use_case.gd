class_name SellSellerItemToPlayerUseCase
extends RefCounted

func execute(item_to_sell: Item) -> bool:
	var cell_id := StateManager.get_player_state().get_first_empty_cell_state_id()

	# Is inventory full?
	if (cell_id == -1):
		return false

	var balance := StateManager.get_player_state().balance

	# Does the player have enough money?
	if (balance < item_to_sell.sale_price):
		return false

	# TODO: Send to server and validate

	StateManager.get_player_state().subtract_balance_amount(item_to_sell.sale_price)

	# NOTE: Item sale_price is passed as cost_price
	var item_copy: Item = Item.new(item_to_sell.item_code, item_to_sell.sale_price)
	StateManager.get_player_state().set_inventory_item(cell_id, item_copy)

	return true
